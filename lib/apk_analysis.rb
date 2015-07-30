require 'ruby_apk'

class DBOX::ApkAnalysis

  def initialize file_name
    @file_name = file_name
    @apk = Android::Apk.new(@file_name)
  end

  def label
    @apk.manifest.label
  end
  
  def app_name
    @apk.resource.find('@string/app_name')
  end

  def md5
    ::DBOX::COMMON::HashHelper.file_md5 @file_name
  end

  def sha256
    ::DBOX::COMMON::HashHelper.file_sha256 @file_name
  end

  def test
    p md5
    p sha256
    p label
    p app_name
  end
end

