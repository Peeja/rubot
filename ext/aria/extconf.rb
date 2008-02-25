require 'rubygems'
require 'mkmf-rice'
require 'facets/module/alias'

# module Logging
#   class << self
#     def open_with_feature
#       @log ||= File::open(@logfile, 'w')
#       @log.sync = true
#       $stderr.reopen(@log)
#       $stdout.reopen(@log)
#       puts "Foo"
#       yield
#     ensure
#       $stderr.reopen(@orgerr)
#       $stdout.reopen(@orgout)
#     end
#     alias_method_chain :open, :feature
# 
#     def postpone_with_feature
#       tmplog = "mkmftmp#{@postpone += 1}.log"
#       open do
#         log, *save = @log, @logfile, @orgout, @orgerr
#         @log, @logfile, @orgout, @orgerr = nil, tmplog, log, log
#         begin
#           log.print(open {yield})
#           @log.close
#           File::open(tmplog) {|t| FileUtils.copy_stream(t, log)}
#         ensure
#           @log, @logfile, @orgout, @orgerr = log, *save
#           @postpone -= 1
#           rm_f tmplog
#         end
#       end
#     end
#     alias_method_chain :postpone, :feature
#   end
# end
# 
# class << self
#   # def link_command_with_puts(*args)
#   #   puts "Foo"
#   #   cmd = link_command_without_puts(*args)
#   #   puts cmd
#   #   cmd
#   # end
#   # alias_method_chain :link_command, :puts
#   
#   # def append_library_with_feature(*args)
#   #   puts "Foo"
#   #   # append_library_without_feature(*args)
#   # end
#   # alias_method_chain :append_library, :feature
#   
#   def message_with_feature(*s)
#     # p s
#     unless $extmk and not $VERBOSE
#       printf(*s)
#       $stdout.flush
#     end
#   end
#   alias_method_chain :message, :feature
#   
#   def checking_for_with_feature(m, fmt = nil)
#     f = caller[0][/in `(.*)'$/, 1] and f << ": " #` for vim
#     m = "checking #{/\Acheck/ =~ f ? '' : 'for '}#{m}... "
#     message "%s", m
#     a = r = nil
#     Logging::postpone do
#       r = yield
#       a = (fmt ? fmt % r : r ? "yes" : "no") << "\n"
#       "#{f}#{m}-------------------- #{a}\n"
#     end
#     # puts a
#     message(a)
#     Logging::message "--------------------\n\n"
#     r
#   end
#   alias_method_chain :checking_for, :feature
#   
#   
#   def have_library_with_foo(lib, func = nil, headers = nil, &b)
#     func = "main" if !func or func.empty?
#     lib = with_config(lib+'lib', lib)
#     checking_for checking_message("#{func}()", LIBARG%lib) do
#       puts "Foo"
#       if COMMON_LIBS.include?(lib)
#         true
#       else
#         libs = append_library($libs, lib)
#         if try_func(func, libs, headers, &b)
#           $libs = libs
#           true
#         else
#           false
#         end
#       end
#     end
#   end
#   alias_method_chain :have_library, :foo
# end

dir_config("Aria", "/usr/local/Aria/include", "/usr/local/Aria/lib")
# unless have_library('Aria', 'Aria::Init')
unless have_library('Aria')
  exit
end

create_makefile('aria')
