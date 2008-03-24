# Adds load paths to extensions for RSpec.  At build, extensions end up in lib/ anyhow.
Dir['ext/*'].each do |dir|
  if test ?d, dir
    $LOAD_PATH.unshift dir
  end
end

# The rake task takes care of this for us, but autotest needs it.
$LOAD_PATH.unshift 'lib' unless $LOAD_PATH.include? 'lib'