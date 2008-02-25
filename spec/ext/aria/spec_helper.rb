require File.join(File.dirname(__FILE__), %w[.. .. spec_helper])

# If we get a LoadError, let the compiler catch up and try again.
begin
  require File.join(File.dirname(__FILE__), %w[.. .. .. ext aria aria])  
rescue LoadError => e
  sleep 0.5
  require File.join(File.dirname(__FILE__), %w[.. .. .. ext aria aria])  
end
