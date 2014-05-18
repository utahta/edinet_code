# coding: utf-8

module EdinetCode

  class Reader
    class Result
      PROPERTIES = [:edinet_code, :kind, :listed, :consolidated, :capital, :settling_day,
                    :submitter, :submitter_en, :submitter_kana, :location, :category, :code]
      PROPERTIES.each do |prop|
        attr_reader prop
      end
      
      def initialize(attr={})
        attr.each do |key, value|
          unless PROPERTIES.include?(key)
            raise PropertyError, "#{key}: プロパティに存在しない名前です"
          end
          instance_variable_set("@#{key.to_s}", value)
        end
      end
    end

    def self.csv(uncompress_file_path)
      return nil unless File.exist?(uncompress_file_path)
      vals = []
      CSV.open(uncompress_file_path, 'r:cp932') do |csv|
        # ヘッダ部分の2行飛ばす
        2.times{
          csv.shift
        }
        csv.each do |row|
          row.map!{|r| r.encode("utf-8")}
          vals.push(Result.new(
            edinet_code: row[0],
            kind: row[1],
            listed: row[2],
            consolidated: row[3],
            capital: row[4],
            settling_day: row[5],
            submitter: row[6],
            submitter_en: row[7],
            submitter_kana: row[8],
            location: row[9],
            category: row[10],
            code: row[11]
          ))
        end
      end
      vals
    end
  end

end

