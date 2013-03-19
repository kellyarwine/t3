require 't3/t3'

use Rack::Reloader, 0

run Rack::Cascade.new([Rack::File.new("public"), T3])