require 'fileutils'
require 'pathname'

module DBOX
module BOX

class Box
 
  def initialize box_name
    @box_name = box_name.gsub('.', '').gsub('\\', '')
    @output_path = File.join(DBOX::Config['docker_dir'], @box_name)
    Dir.mkdir @output_path unless File.exist?(@output_path)
    @all_number = 0
    @tmp_number = 0
    @start_time = Time.now
    @queue = ::DBOX::DataQueue.new
  
    # 是否需要运行
    @running = true
    # 是否需要持续运行
    @keep_running = true
  end

  def start
    @recent_start_time = Time.now
    print "start #{@box_name}\n"
    run_command = "docker run --rm -ti -v #{@output_path}:/samples --name=#{@box_name} #{DBOX::Config['docker_image_name']}"
    print "#{run_command}\n"
    @running = true
    Thread.new { `#{run_command}` }
  end
 
  def stop
    @running = false
  end

  def kill
    @running = false
    @keep_running = false
  end

  def _stop
    print "stop #{@box_name}\n"
    run_command = "docker kill #{@box_name}"
    print "#{run_command}\n"
    `#{run_command}`
    sleep 1
    run_command = "docker rm #{@box_name}"
    print "#{run_command}\n"
    `#{run_command}`
    sleep 1
    @tmp_number = 0
  end

  # 运行循环
  # 如果 running=false 则重启
  # 如果 keep_running=false, running=false, 则全部退出
  def run
    start
    while @keep_running
      # 启动延时
      sleep_after_start
      begin
        run_task
      rescue => e
        p e
      end
      _stop
      start
    end
  end

  # 持续运行任务, 如果退出则自动重启
  def run_task
    @running = true
    while @running
      task = @queue.task_pop
      if task
        print "#{@box_name} start task : #{task.to_json}\n"
        @tmp_number += 1
        @all_number += 1
        _run_task task
        return if @tmp_number >= ::DBOX::Config['analisys_number']
      else
        print "#{@box_name} sleep 2\n"
        sleep 2
      end
    end
  end

  def _run_task task
    apk = nil
    if task['task_id']
      apk = ::DBOX::MODEL::TaskList.where(:id => task['task_id'].to_i).first
      apk.running
      apk.start_time = Time.now.to_i
      apk.save
    end
    
    task_pathname = Pathname.new(task['file'])
    FileUtils.cp(task['file'], @output_path)
    run_apk task_pathname.basename, task['run_time']

    if apk
      apk.run_end
      apk.end_time = Time.now.to_i
      apk.save
    end

    # 移动输出文件
    ::DBOX::Config['output_file_list'].each do |f|
      file_name = File.join(@output_path, f)
      FileUtils.mv file_name, task_pathname.dirname.to_s if File.exists?(file_name)
    end
  end

  def run_apk file_name, time = 60
    docker_enter_file = DBOX::ROOT_PATH.join('docker_image', 'docker_enter')
    run_command = "#{docker_enter_file} #{@box_name} /build/run_apk.sh /samples/#{file_name} #{time}"
    print "#{run_command}\n"
    `#{run_command}`
  end

  def sleep_after_start
    tmp_time_int = Time.now.to_i
    if ((tmp_time_int - @recent_start_time.to_i) < ::DBOX::Config['sleep_time_after_start'].to_i)
      print "sleep after start\n"
      sleep (::DBOX::Config['sleep_time_after_start'].to_i - (tmp_time_int - @recent_start_time.to_i))
    end
  end

end

end
end
