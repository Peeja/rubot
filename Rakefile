# Look in the tasks/setup.rb file for the various options that can be
# configured in this Rakefile. The .rake files in the tasks directory
# are where the options are used.

load 'tasks/setup.rb'

ensure_in_path 'lib'
require 'rubot'

task :default => 'spec:run'

PROJ.name = 'rubot'
PROJ.authors = 'Peter Jaros (Peeja)'
PROJ.email = 'peter.a.jaros@gmail.com'
PROJ.url = 'FIXME (project homepage)'
PROJ.rubyforge_name = 'rubot'

PROJ.spec_opts << '--color'

# EOF
