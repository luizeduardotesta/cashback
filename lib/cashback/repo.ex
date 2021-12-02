defmodule Cashback.Repo do
  use Ecto.Repo,
    otp_app: :cashback,
    adapter: Ecto.Adapters.Postgres
end
