MPcharge/web: the web service + website for MPcharge
====================================================

This web service / website is the entry point for MPcharge info and data.

MPcharge is/will be an international math & physics competition, see the website for more info (once it is online).

It provides the info website, the admin/organizer interface, the team registration interface, and of course the submits and results.

The Plan
--------

I will attempt to make this

- **fast**: able to handle hundreds of requests per second with a single instance
- **reliable**: this means *stable* (i.e. always online), *secure* (i.e. no unauthorized access), and *fool- and weather-proof* (i.e. information remaining consistent under all circumstances)

The service will be RESTful, and therefore language-agnostic and simple to use from 3<sup>rd</sup>-party apps.

----------------------------------------------------------------------------------

If you would like to talk into the development, feel free to comment on code, file issues, send pull requests or anything else -- any help is appreciated.

----------------------------------------------------------------------------------

This app is meant to run on the [Heroku](http://www.heroku.com) infrastructure.

To launch locally, use `foreman start` (foreman can be installed e.g. as a ruby gem).
