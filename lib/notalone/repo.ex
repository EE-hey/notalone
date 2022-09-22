defmodule Notalone.Repo do
  use Ecto.Repo,
    otp_app: :notalone,
    adapter: Ecto.Adapters.Postgres
end
