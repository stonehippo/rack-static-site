# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
#  http://sam.zoy.org/wtfpl/COPYING for more details.

require 'bundler/setup'

Bundler.require(:default, ENV['RACK_ENV'])

use Rack::Auth::Basic, "Please Sign In" do |username, password|
  [username, password] == ['username', 'password'] # Change the values to whatever you want
end

# Cache items placed in the following folders
use Rack::StaticCache, :urls => ['/assets', '/css', '/js', '/lib'], :root => 'public'

use Rack::Rewrite do
  rewrite '/', '/index.html'
  rewrite %r{^(.+)\.(\d+)\.(js|css|png|jpg|gif|pdf)$}, '$1.$3'
end

run Rack::Directory.new('public')