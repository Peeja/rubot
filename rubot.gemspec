Gem::Specification.new do |s|
  s.name = %q{rubot}
  s.version = "0.5.0"
  s.date = %q{2008-04-30}
  s.summary = %q{FIXME (describe your package)}
  s.require_paths = ["lib", "ext"]
  s.email = %q{peter.a.jaros@gmail.com}
  s.homepage = %q{http://rubot.org/}
  s.description = %q{FIXME (describe your package)}
  s.default_executable = %q{rubot}
  s.has_rdoc = true
  s.authors = ["Peter Jaros (Peeja)"]
  s.files = [".autotest", "Adapters.txt", "History.txt", "Manifest.txt", "README.txt", "Rakefile", "bin/rubot", "examples/navigate.rbt", "ext/rubot_aria/Makefile", "ext/rubot_aria/RAGenericAction.cpp", "ext/rubot_aria/RAGenericAction.h", "ext/rubot_aria/RAGenericAction.o", "ext/rubot_aria/RARobotManager.cpp", "ext/rubot_aria/RARobotManager.h", "ext/rubot_aria/RARobotManager.o", "ext/rubot_aria/extconf.rb", "ext/rubot_aria/rubot_aria.cpp", "ext/rubot_aria/rubot_aria.o", "ext/rubot_aria/rubot_aria.so", "lib/rubot.rb", "lib/rubot/adapters.rb", "lib/rubot/adapters/aria.rb", "lib/rubot/adapters/aria/action_desired.rb", "lib/rubot/adapters/aria/robot.rb", "lib/rubot/adapters/asimov.rb", "lib/rubot/dsl.rb", "lib/rubot/meta.rb", "spec/load_paths.rb", "spec/rubot/adapters/aria/robot_manager_spec.rb", "spec/rubot/adapters/aria/robot_spec.rb", "spec/rubot/adapters/aria_spec.rb", "spec/rubot/adapters/spec_helper.rb", "spec/rubot/dsl_spec.rb", "spec/rubot_spec.rb", "spec/spec.opts", "spec/spec_helper.rb", "tasks/ann.rake", "tasks/annotations.rake", "tasks/doc.rake", "tasks/gem.rake", "tasks/manifest.rake", "tasks/post_load.rake", "tasks/rubyforge.rake", "tasks/setup.rb", "tasks/spec.rake", "tasks/svn.rake", "tasks/test.rake"]
  s.rdoc_options = ["--main", "README.txt"]
  s.extra_rdoc_files = ["Adapters.txt", "History.txt", "README.txt", "bin/rubot"]
  s.executables = ["rubot"]
  s.extensions = ["ext/rubot_aria/extconf.rb"]
  s.add_dependency(%q<rice>, [">= 1.0.1"])
  s.add_dependency(%q<facets>, [">= 2.3.0"])
end
