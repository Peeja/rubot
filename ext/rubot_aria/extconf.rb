require 'rubygems'
require 'mkmf-rice'

dir_config("Aria", "/usr/local/Aria/include", "/usr/local/Aria/lib")
unless have_library('Aria')
  exit
end

create_makefile('rubot_aria')
