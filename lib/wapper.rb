require 'fileutils'

class ::DBOX::Wapper 

  # 开始检测文件
  def self.check file_name
    return nil if not File.exists?(file_name)
    file_name = file_name
    apk = ::DBOX::ApkAnalysis.new(file_name)
    apk_md5 = apk.md5
    apk_sha256 = apk.sha256
    task_name = "#{Time.now.to_i}#{apk_md5[8...16]}"
    task = ::DBOX::MODEL::TaskList.new(:task_name => task_name)
    apk_list = ::DBOX::MODEL::ApkList.where(:md5 => apk_md5, :sha256 => apk.sha256).first
    apk_list = nil
    # 以前分析过此文件
    if apk_list 
      task.apk_list_id = apk_list.id
      task.never_run
      task.save
      File.delete file_name
    else
      # 添加APKLIST, 创建分析任务
      apk_list = ::DBOX::MODEL::ApkList.new
      apk_list.md5 = apk_md5
      apk_list.sha256 = apk_sha256
      apk_list.app_name = apk.app_name
      apk_list.label = apk.label
      apk_list.task_name = task_name
      apk_list.save
      apk_id = apk_list.id

      task.apk_list_id = apk_list.id
      task.run_wait
      task.submit_time = Time.now.to_i
      task.save

      # 移动文件到统一目录
      move_to = File.join(::DBOX::Config['apk_base_dir'], apk_id.to_s)
      Dir.mkdir(move_to)
      move_to_file = File.join(move_to, "#{task_name}.apk")
      FileUtils.mv(file_name, move_to_file)

      print "start check for #{apk}\n"

      ::DBOX::DataQueue.new.task_push task_name, move_to_file, task.id
    end
  end

end
