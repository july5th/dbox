require_relative './lib/libdbox.rb'

def test_box
  pool = DBOX::BOX::BoxBatch.new
  pool.run_all

  DBOX::DataQueue.new.test
  sleep 100
end


def test_apk
  a = DBOX::ApkAnalysis.new('/home/ruin/git/sendbox/dbox/test/test.apk')
  a.test
end

def test_wapper
  ::DBOX::Wapper.check('/tmp/test.apk')
end

def start
  pool = DBOX::BOX::BoxBatch.new.run_all

  while true
    #::DBOX::Wapper.check '/tmp/test.apk'
    #::DBOX::Wapper.check '/tmp/jingdong.apk'

    sleep 10000
  end
end

start
