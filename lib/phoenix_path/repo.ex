defmodule PhoenixPath.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_path,
    adapter: Ecto.Adapters.Postgres
end
