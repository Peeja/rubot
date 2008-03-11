# Adds load paths to extensions for RSpec.  At build, extensions end up in lib/ anyhow.
Dir['ext/*'].each do |dir|
  if test ?d, dir
    $LOAD_PATH << dir
  end
end
