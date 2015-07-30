require 'digest/md5' 
require 'digest/sha2'

module DBOX
module COMMON

class HashHelper

  def self.file_md5 file_name
    file = File.open(file_name, 'r')
    data = Digest::MD5.hexdigest(file.read)
    file.close
    return data
  end

  def self.file_sha256 file_name
    file = File.open(file_name, 'r')
    data = Digest::SHA256.hexdigest(file.read)
    file.close
    return data
  end

end

end
end
