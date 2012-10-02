Rack Static Site Template
=========================

Pretty much what it says on the tin: this is a template for creating a basic, static website using Rack.

There are a few amenities here, including support for caching and URL rewriting baked in. And HTML template in the `/public` folder is a super-simple starter for a clean page design. :)

Deploying to Heroku
-------------------

This template is all set to deploy to Heroku, including a valid Procfile to get everything revved up correctly.

If you have the Heroku Toolbelt installed, you can stand up the server for local dev with `foreman`:

    $ foreman start

And of course, deploying is as simple as:

    $ heroku create
    $ git push heroku master