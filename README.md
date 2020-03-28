# Speaker Karaoke

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Install Node.js dependencies with `cd assets && npm install`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
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

* Open a browser to `http://speaker-karaoke.net/` and fill out the form.
  Set hostname to `speaker-karaoke.net` and enable virtual host naming.

* Workspace:

  * `mix phx.gen.secret` to generate a _secret key base_ (for production); store it securely, but not in source code control

* `ssh root@speaker-karaoke.net`
  
  * `dokku plugin:install https://github.com/dokku/dokku-postgres.git`
  
  * `dokku postgres:create skdb`
  
  * `dokku apps:create skweb`
  
  * `dokku postgres:link skdb skweb`

  * `dokku config:set skweb PORT=5000 SECRET_KEY_BASE="*SKB*" WEB_HOST="speaker-karaoke.net"`

    Use the secret key base generated above.

* Workspace:

  * `git remote add dokku dokku@speaker-karaoke.net:skweb`

  * `git push dokku master`

    This can take a long time, especially the first time.

  * `ssh root@speaker-karaoke.net`

    * `dokku run skweb mix ecto.migrate`

      * Or `ecto.setup` to setup test data

 * Open `http://speaker-karaoke.net/` in a browser

### Hard Migrations

If you need to `mix ecto.reset` the deployed app (drop and rebuild the database) then:

  * `ssh root@speaker-karaoke.net`

    * `dokku ps:stop skweb`

    * `dokku run skweb mix ecto.reset`

    * `dokku ps:start skweb`

### Dokku Version

On 30 Dec 2019, upgraded to dokku 0.19.11 (latest), and executed dokku-update.

### Node Version

To upgrade the node version, update the `phoenix_static_buildpack.config` file.

Other notes:

* [Postgres and Volumes](https://github.com/dokku/dokku-postgres/issues/78)