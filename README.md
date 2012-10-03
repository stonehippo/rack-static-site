Rack Static Site Template
=========================

Pretty much what it says on the tin: this is a template for creating a basic, static website using Rack.

There are a few amenities here, including support for caching and URL rewriting baked in. The site is password protected by default, too.

And HTML template in the `/public` folder is a super-simple starter for a clean page design. :)

Cached Files
------------

The site template enables `Rack::StaticCache` to give you the benefits of client-side caching out-of-the-box. If you create any of the following directories under `/public`, the contents will be given a set of long-lived (1 year) `Expires` and `Cache-Control` headers:

    assets
    css
    js
    lib

You can disable caching entirely by commenting out the `Rack::StaticCache` stuff in `config.ru`, or you can take control of how assets are cached with **cache-busting**.

Using Cache-Busting
-------------------

The template includes a rewrite rule that will allow you to use cache-busting with some common Web asset types. Cache-busting is a simple technique that let's you take advantage of client-side (and proxy) caching while retaining control over pushing new versions of assets whenever you need to.

It works like this:

1. Create an asset for use in your site in one of the cached folders (e.g. `css/styles.css`)
2. Whenever you include a reference to the file someplace, such as a `<link>` to the stylesheet, add some numbers to the filename, between the name and the extension (e.g. `<link rel='stylesheet' href='/css/styles.20121002.css'>`)
3. Profit.

So, what exactly is going on here?

It's pretty simple, really. We have a default rewrite rule in our app config that converts the URL request from the version with a number to the plain version, so our requests will be satisfied by the real file. Any caches that wish to store the resource will use the number-included path as the key to the cached item. 

Whenever you want to update the file, and ensure that everyone who comes back to your site gets the latest and greatest, you need to do a couple of things:

1. Update the real file.
2. Change the URL reference to it to use different number.

Changing the reference URL will effectively invalidate the item in any and all caches*. From the perspective of the cache, this is a new document, and it will now cache the new version and begin using that version.

One tip: using something sensible for the cache-busting number included in the URL reference, such as a timestamp based on the date (and perhaps, time). This will keep you much saner that the valid, but almost useless `styles.1.css`. If you are diligent, you can look at the URL and know exactly when you last updated the resource.

The default config supports cache-busting on assets with the following extensions:

    .js
    .css
    .png
    .jpg
    .gif
    .pdf

\* Well, technically not. The original item is still cached, but it's not being used any more.


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