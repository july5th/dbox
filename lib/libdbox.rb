require 'pathname'
require 'active_record'

module DBOX

  ROOT_PATH = Pathname.new(__FILE__).realpath.expand_path.parent.parent
  LIB_PATH = ROOT_PATH.join('lib')
  CONF_PATH = ROOT_PATH.join('config')

  def self.load_path file_path
    Dir[file_path].each do |file|
      load file
      print "load #{file}\n"
    end
  end

end


path_list = ['load_config.rb', 
             'common/*.rb', 
             'data_queue.rb', 
             'apk_analysis.rb', 
             'box/*.rb', 
             'model.rb', 
             'model/*.rb',
             'wapper.rb']

path_list.each do |path|
  ::DBOX.load_path DBOX::LIB_PATH.join(path).to_s
end

