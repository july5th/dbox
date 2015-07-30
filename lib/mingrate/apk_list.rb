#encoding: utf-8

module DBOX
module MINGRATE

class ChangeApkLists < ActiveRecord::Migration
  def change
    begin
      create_table :apk_lists do |t|
        t.string :label
        t.string :app_name
        t.string :md5
        t.string :sha256
        t.string :task_name

        t.text :log
        t.integer :status, :null => false, :default => 0

        t.timestamps
      end
    rescue
      print "创建apk_list数据表失败.\n"
    end
  end
end

end
end
