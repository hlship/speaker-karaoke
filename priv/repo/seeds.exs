# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     SK.Repo.insert!(%SK.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

defmodule Seeds do
  import SK.Repo
  alias SK.Infra.MOTD

  insert!(%MOTD{message_text: "Not much to see here, yet!"})
  insert!(%MOTD{mess˝age_text: "Running on Digital Ocean, even!"})

end
