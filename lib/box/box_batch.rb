require 'thread'

module DBOX
module BOX

class BoxBatch
 
  def initialize
    @box_number = ::DBOX::Config['batch_number']
    @box_hash = {}
    1.upto(@box_number) do |i|
      box_name = "dbox-#{i}"
      @box_hash[box_name] = ::DBOX::BOX::Box.new(box_name)
    end
  end

  def start box_name
    print "start #{box_name}\n"
    Thread.new { @box_hash[box_name].start }
  end

  def stop box_name
    print "stop #{box_name}\n"
    Thread.new { @box_hash[box_name].stop }
  end

  def run box_name
    print "run #{box_name}\n"
    Thread.new { @box_hash[box_name].run }
  end

  def start_all
    @box_hash.keys.each do |box_name|
      start box_name
    end
  end

  def stop_all
    @box_hash.keys.each do |box_name|
      stop box_name
    end
  end

  def run_all
    @box_hash.keys.each do |box_name|
      run box_name
    end
  end

  def analisys_number
  end

end

end
end
