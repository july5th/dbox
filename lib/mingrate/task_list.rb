#encoding: utf-8

module DBOX
module MINGRATE

class ChangeTaskLists < ActiveRecord::Migration
  def change
    begin
      create_table :task_lists do |t|
        t.string :task_name

        t.integer :apk_list_id, :null => false

        t.text :log
        t.integer :status, :null => false, :default => 0

        t.integer :submit_time
        t.integer :start_time
        t.integer :end_time

        t.timestamps
      end
    rescue
      print "创建task_list数据表失败.\n"
    end
  end
end

end
end
