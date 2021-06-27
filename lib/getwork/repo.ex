defmodule Getwork.Repo do
  use Ecto.Repo,
    otp_app: :getwork,
    adapter: Ecto.Adapters.Postgres
end
