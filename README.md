Rack Static Site Template
=========================

Pretty much what it says on the tin: this is a template for creating a basic, static website using Rack.

There are a few amenities here, including support for caching and URL rewriting baked in. The site is password protected by default, too.

And HTML template in the `/public` folder is a super-simple starter for a clean page design. :)

Modifying or Disabling Password Authentication
----------------------------------------------

The site is password protected by default, using HTTP Basic Authentication. Not exactly the more secure solution (if you're not running the site on HTTPS, authentication info is transmitted in the clear).

If you want to change the username and password for the site, edit `config.ru` and change the values in the array used for the authentication check:

    [username, password] == ['username', 'password'] # Change the values to whatever you want

And if you want to get rid of authentication entirely, just comment out the `Rack::Auth::Basic` block.

Deploying to Heroku
-------------------

This template is all set to deploy to Heroku, including a valid Procfile to get everything revved up correctly.

If you have the Heroku Toolbelt installed, you can stand up the server for local dev with `foreman`:

    $ foreman start

And of course, deploying is as simple as:

    $ heroku create
    $ git push heroku master