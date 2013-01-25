# This program is free software. It comes without any warranty, to
# the extent permitted by applicable law. You can redistribute it
# and/or modify it under the terms of the Do What The Fuck You Want
# To Public License, Version 2, as published by Sam Hocevar. See
#  http://sam.zoy.org/wtfpl/COPYING for more details.

# if you want to set a default port for this app, remove the first hash/pound
# from the next line and set the port number to whatever you need it to be
##\ -p 1234

require 'bundler/setup'

Bundler.require(:default, ENV['RACK_ENV'])

# Set the authentication conditionally based on the RACK_ENV environment variable.
# In order to set the environment variable for RACK_ENV on heroku you need to add a 
# config variable using the heroku command on the CLI. Documentation for that can be 
# found at: https://devcenter.heroku.com/articles/config-vars 
#if ENV['RACK_ENV'] == 'staging'
    use Rack::Auth::Basic, "Please Sign In" do |username, password|
      [username, password] == ['username', 'password'] # Change the values to whatever you want
    end
#end

# Cache items placed in the following folders
use Rack::StaticCache, :urls => ['/assets', '/css', '/js', '/lib'], :root => 'public'

use Rack::Rewrite do
  rewrite '/', '/index.html'
  # Uncomment the next line if you want cache-busting URLs and you are NOT using Rack::StaticCache
  # rewrite %r{^(.+)\-(\d+)\.(js|css|png|jpg|gif|pdf)$}, '$1.$3'
end

run Rack::Directory.new('public')