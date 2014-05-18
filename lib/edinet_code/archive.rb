# coding: utf-8

module EdinetCode

  class Archive
    def self.unzip(compress_file_path)
      return nil unless File.exists?(compress_file_path)
      compress_dir = File.dirname(compress_file_path)
      uncompress_file_path = nil
      Zip::File.open(compress_file_path) do |zip_file|
        zip_file.each do |entry|
          if File.extname(entry.name) == ".csv"
            uncompress_file_path = File.join(compress_dir, entry.name)
            if File.exist?(uncompress_file_path)
              puts "既に解凍済みです:#{uncompress_file_path}"
              break
            end
            entry.extract(uncompress_file_path)
            break
          end
        end
      end
      uncompress_file_path
    end
  end

end
