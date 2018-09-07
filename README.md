# Speakerkaraoke

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.create && mix ecto.migrate`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](http://www.phoenixframework.org/docs/deployment).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: http://phoenixframework.org/docs/overview
  * Docs: https://hexdocs.pm/phoenix
  * Mailing list: http://groups.google.com/group/phoenix-talk
  * Source: https://github.com/phoenixframework/phoenix


## Dokku / Digital Ocean Notes

Adapted from [this blog post](https://medium.com/@jonlunsford/elixir-up-and-running-with-dokku-on-digital-ocean-ce332d64224c) and
[this tutorial](https://phoenixbasics.github.io/index.html).

The Droplet is a VM running Docker; we'll be putting both the web tier and the db tier as
containers inside this one VM.

`dokku` commands execute from a SSH shell into the Droplet

* Map `speaker-karaoke.howardlewisship.com` to IP 138.68.240.182 (the Droplet IP, on
  Digital Ocean)

* Open a browser to `http://speaker-karaoke.howardlewisship.com` and fill out the form.
  Set hostname to `speakerkaraoke.howardlewisship.com` and enable virtual host naming.

* `ssh root@speaker-karaoke.howardlewisship.com`
  
  * `dokku plugin:install https://github.com/dokku/dokku-postgres.git`
  
  * `dokku postgres:create skdb`
  
  * `dokku apps:create skweb`
  
  * `dokku postgres:link skdb skweb`

* Workspace:

  * `git remote add dokku dokku@speaker-karaoke.howardlewisship.com:skweb`

  * `git push dokku master` --- not quite working yet!

Other notes:

* [Postgres and Volumes](https://github.com/dokku/dokku-postgres/issues/78)