#encoding: utf-8

class ::DBOX::MODEL::TaskList < ActiveRecord::Base

  def never_run
    self.status = -1
  end

  def run_wait
    self.status = 1
  end

  def running
    self.status = 2
  end
 
  def run_end
    self.status = 3
  end

end

