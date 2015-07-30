module DBOX
module MODEL
  ::ActiveRecord::Base.establish_connection(::DBOX::Config['database'])
end
end
