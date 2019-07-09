# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     Sk.Repo.insert!(%Sk.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias Sk.Repo
alias Sk.Accounts.Speaker

Repo.insert!(%Speaker{name: "Howard", twitter_id: "hlship"})
Repo.insert!(%Speaker{name: "Merlyn Albery-Speyer", twitter_id: "curiousattemptbunny"})
Repo.insert!(%Speaker{name: "Jacob Lewis Ship", twitter_id: "pokemonjacob"})
