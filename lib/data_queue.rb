require 'redis'
require 'json'

class DBOX::DataQueue

  def initialize 
    @queue = Redis.new ::DBOX::Config['redis']
    @task_queue_name = 'task_queue'
  end

  def task_push task_name, file_name, task_id = nil, run_time = 60
    @queue.lpush @task_queue_name, {:task_name => task_name, :file => file_name, :run_time => run_time, :task_id => task_id}.to_json
  end

  def task_pop
    data = @queue.lpop @task_queue_name
    if data
      return JSON.parse data
    else
      return nil
    end
  end

  def test
    create_test_task 111
    create_test_task 222
    create_test_task 333
  end

  def create_test_task number
    task_push "test_task#{number}", "/tmp/#{number}.apk"
  end
end

