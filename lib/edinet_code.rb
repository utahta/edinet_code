# coding: utf-8
$:.unshift(File.dirname(__FILE__)) unless $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))
require "selenium-webdriver"
require "headless"
require "zip"
require "tmpdir"
require "date"
require "csv"

require "edinet_code/version"
require "edinet_code/exception"
require "edinet_code/archive"
require "edinet_code/downloader"
require "edinet_code/reader"

module EdinetCode
  module_function

  def get(headless=true)
    download_dir = File.join(Dir.tmpdir, 'edinet_code')
    download_path = File.join(download_dir, "Edinetcode_#{Date.today.strftime("%Y%m%d")}.zip") # ファイル名のフォーマットは変更できない...
    
    if headless
      Headless.ly do
        Downloader.fetch(download_path)
      end
    else
      Downloader.fetch(download_path)
    end
    uncompress_file_path = Archive.unzip(download_path)
    Reader.csv(uncompress_file_path)
  end

  def get_code_exists(headless=true)
    vals = get(headless)
    vals.delete_if{|val| val.code == ""}
  end

end

