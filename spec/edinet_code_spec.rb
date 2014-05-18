# coding: utf-8
require 'spec_helper'

describe EdinetCode do

  describe EdinetCode::Downloader do
    before(:all) do
      @tmp_dir = File.join(Dir.tmpdir, "edinet_code_test")
      @zip_path = File.join(@tmp_dir, "Edinetcode_#{Date.today.strftime("%Y%m%d")}.zip")
      @file_path = File.join(@tmp_dir, "EdinetcodeDlInfo.csv")
    end

    it "ファイルがダウンロードできること" do
      EdinetCode::Downloader.fetch(@zip_path)
      expect(File.exists?(@zip_path)).to eq true
    end
 
    describe EdinetCode::Archive do
      it "Zipが解凍できること" do
        uncompress_file_path = EdinetCode::Archive.unzip(@zip_path)
        expect(uncompress_file_path).to eq @file_path
      end

      describe EdinetCode::Reader do
        it "CSVを読み込めること" do
          vals = EdinetCode::Reader.csv(@file_path)
          expect(vals.size).to be >= 3000
        end

        it "CSVで読み込んだデータが正しいこと" do
          # とりあえず空じゃなければ良しとする
          vals = EdinetCode::Reader.csv(@file_path)
          result = vals[0]
          expect(result.edinet_code).not_to eq ""
          expect(result.kind).not_to eq ""
          expect(result.listed).not_to eq ""
          expect(result.consolidated).not_to eq ""
          expect(result.capital).not_to eq ""
          expect(result.settling_day).not_to eq ""
          expect(result.submitter).not_to eq ""
          expect(result.submitter_en).not_to eq ""
          expect(result.submitter_kana).not_to eq ""
          expect(result.location).not_to eq ""
          expect(result.category).not_to eq ""
          expect(result.code).not_to eq ""
        end
      end
    end

    after(:all) do
      if File.exists?(@tmp_dir)
        FileUtils.rm_r(@tmp_dir)
      end
    end
  end

end

