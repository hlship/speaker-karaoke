defmodule SKWeb.PageController do
  use SKWeb, :controller
  alias SK.Repo
  alias SK.Infra.MOTD
  import Ecto.Query

  def index(conn, _params) do
    # Doing this work here is not idea; it will likely move to a plug (I think)
    # in the future.
    now = NaiveDateTime.utc_now()

    q = from m in MOTD,
        where: is_nil(m.expires_at) or m.expires_at < ^now,
        order_by: [desc: m.updated_at]

    render(conn, "index.html", motds: Repo.all(q))
  end
end
