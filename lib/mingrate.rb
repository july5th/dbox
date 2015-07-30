::DBOX.load_path DBOX::LIB_PATH.join('mingrate/*.rb')

::DBOX::MINGRATE.constants.each do |x|
    x_class = ::DBOX::MINGRATE.class_eval x.to_s
    x_class.new.change
end
