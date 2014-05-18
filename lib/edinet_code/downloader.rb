# coding: utf-8

module EdinetCode

  class Downloader
    def self.fetch(download_path, wait_sec=300)
      return true if File.exist?(download_path)
      download_dir = File.expand_path(File.dirname(download_path))
      # require Firefox
      profile = Selenium::WebDriver::Firefox::Profile.new
      profile['browser.download.folderList'] = 2
      profile['browser.download.dir'] = download_dir
      profile['browser.helperApps.neverAsk.saveToDisk'] = "application/octet-stream"
      driver = Selenium::WebDriver.for :firefox, :profile => profile
      
      driver.navigate.to 'https://disclosure.edinet-fsa.go.jp/E01EW/BLMainController.jsp?uji.bean=ee.bean.W1E62071.EEW1E62071Bean&uji.verb=W1E62071InitDisplay&TID=W1E62071&PID=W0EZ0001&SESSIONKEY=&lgKbn=2&dflg=0&iflg=0'
      element = driver.find_element(:class, 'main_table_1').find_elements(:xpath, ".//a")[0]
      element.click
      
      # ダウンロードできたかどうか調べる
      # ファイルができるまで何秒間か待機する...
      wait_sec.times{|i|
        break if File.exist?(download_path)
        print "\rwaiting.#{"."*i}"
        sleep 1
      }
      print "\n"
      driver.quit
      
      File.exist?(download_path)
    end
  end

end
