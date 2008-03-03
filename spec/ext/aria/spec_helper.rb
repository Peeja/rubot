require File.join(File.dirname(__FILE__), %w[.. .. spec_helper])

# TODO: Refactor and grep the error string to find the real problem.
begin
  # If we get a LoadError, let the compiler catch up and try again.
  begin
    require File.join(File.dirname(__FILE__), %w[.. .. .. ext aria aria])  
  rescue LoadError => e
    sleep 0.5
    require File.join(File.dirname(__FILE__), %w[.. .. .. ext aria aria])  
  end
  $spec_skip = false
rescue LoadError => e
  puts "Extension 'aria' not built. Skipping..."
  $spec_skip = true
end
