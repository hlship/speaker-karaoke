# Speaker Karaoke

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server`

Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: http://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix

## Running Locally

Install the PostgreSQL.app locally via `brew install homebrew/cask/postgres`.  Database `sk_dev` is created and used for local development, and `sk_test` for local testing.

Local development enables the [Phoenix LiveView Dashboard](http://localhost:4000/dashboard).
 
## Dokku / Digital Ocean Notes

Adapted from [this blog post](https://medium.com/@jonlunsford/elixir-up-and-running-with-dokku-on-digital-ocean-ce332d64224c) and
[this tutorial](https://phoenixbasics.github.io/index.html).

The Droplet is a VM running Docker; we'll be putting both the web tier and the db tier as
containers inside this one VM.

`dokku` commands execute from a SSH shell into the Droplet

* Create a new droplet, `speaker-karaoke.net`

* Choose "Marketplace" for the image, find the *Dokku* image under "Developer Tools"

* Click `Create Droplet`

* Data center region: San Francisco 3

* Enable the `Monitoring` option

* Setup SSH w/ a key you control

* Use `speaker-karaoke` for the hostname

* Setup DNS for `speaker-karaoke.net` to use Digital Ocean's name servers: `ns[1-3].digitalocean.com` (this is done
  at the Registrar page for `speaker-karaoke.net`, not at Digital Ocean).

* Use [Digital Ocean's UI](https://cloud.digitalocean.com/networking/domains) to map `speaker-karaoke.net` to the droplet (may be done automatically)

* Open a web browser to `http://speaker-karaoke.net/` to fill out the Dokku Setup form:

  * Set the hostname to `speaker-karaoke.net`

  * Enable virtualhost naming

  * Note: may have to wait for `speaker-karaoke.net` DNS to propagate.

* Workspace:

  * `mix phx.gen.secret` to generate a _secret key base_ (for production); store it securely, but not in source code control

  * `mix phx.gen.secret 32` to generate a _signing salt_ (for production); store it securely, but not in source code control

* `ssh root@speaker-karaoke.net`
  
  * `dokku plugin:install https://github.com/dokku/dokku-postgres.git`
  
  * `dokku postgres:create skdb`
  
  * `dokku apps:create skweb`
  
  * `dokku postgres:link skdb skweb`

  * `dokku config:set skweb PORT=5000 SECRET_KEY_BASE="**" SIGNING_SALT="**" WEB_HOST="speaker-karaoke.net"`

    Use the secret key base and signing salt generated above.

  * The next steps set up automatic SSL handling via LetsEncrypt (see
    [these notes](https://medium.com/@pimterry/effortlessly-add-https-to-dokku-with-lets-encrypt-900696366890)).
    Need to ensure that DNS is properly setup before this will work.

  * `dokku plugin:install https://github.com/dokku/dokku-letsencrypt.git`

  * There's some oddness related to the mapping from URL to the skweb container; `speaker-karoke.net` requests are sent to `skweb` (perhaps
    because it's the only web container defined?) but the default virtual hostname is `skweb.speaker-karaoke.net` and that breaks
    things when Lets Encrypt sends an HTTP request to verify domain ownership.  We fix it as:

    * `dokku domains:remove skweb skweb.speaker-karaoke.net`

    * `dokku domains:add skweb speaker-karaoke.net`
  
  * `dokku config:set --no-restart skweb DOKKU_LETSENCRYPT_EMAIL=h@lewisship.net`

  * `dokku letsencrypt:enable skweb` --  generate an initial certificate and reconfigure nginx to use it

  * `dokku letsencrypt:cron-job --add`  -- ensure that the certificate is renewed periodically

* Workspace:

  * `git remote add dokku dokku@speaker-karaoke.net:skweb`

  * `git push dokku master`

    This can take a long time, especially the first time.

  * `ssh root@speaker-karaoke.net`

    * `dokku run skweb mix ecto.migrate`

      * Or `ecto.setup` to setup test data

 * Open `https://speaker-karaoke.net/` in a browser

### Hard Migrations

If you need to `mix ecto.reset` the deployed app (drop and rebuild the database) then:

  * `ssh root@speaker-karaoke.net`

    * `dokku ps:stop skweb`

    * `dokku run skweb mix ecto.reset`

    * `dokku ps:start skweb`

### Things I've learned about Dokku

* The Droplet (the container VM) runs `nginx` and forwards requests into the `skweb` container.

* Deployments spin up a new container, wait for it to start running, then cycles the names of the running vs. new container and shuts down the old container.
  So, there's a little overlap where old and new containers are both running, and perhaps a tiny gap in service at the instant of switchover.

* The data directory for Postgres lives on the VM and is mounted as a volume inside the Postgres container; eventually it can be
  put on in a [shared directory and moved to block storage](https://github.com/dokku/dokku-postgres/issues/78).

* Attempting to upgrade the version of Dokku provided by marketplace broke things

### Questions I have about Phoenix

* In production, `assets.deploy` creates minimized versions of the assets,
  and the existing `Routes.static_path` function uses those versions, but having trouble finding where static_path gets defined.

  > It's defined [here](https://hexdocs.pm/phoenix/Phoenix.Endpoint.html#c:static_path/1) but still
    having trouble identifying how that function gets added to `Routes`.

## More Links

* [Setting up Tailwind CSS pipeline](https://sergiotapia.com/phoenix-160-liveview-esbuild-tailwind-jit-alpinejs-a-brief-tutorial) 

* [Adding Tailwind CSS to Phoenix 1.6](https://pragmaticstudio.com/tutorials/adding-tailwind-css-to-phoenix)

* [Tailwind Standalone](https://fly.io/phoenix-files/tailwind-standalone/)
