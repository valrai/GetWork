defmodule GetworkWeb.Auth.BasicAuthPlug do
  import Plug.BasicAuth

  @behaviour Plug

  @impl true
  def init(_opts) do
    []
  end

  @impl true
  def call(conn, _opts) do
    basic_auth(conn,
      username: System.get_env("BASIC_AUTH_USERNAME", "getwork"),
      password: System.get_env("BASIC_AUTH_PASSWORD", "getwork123")
    )
  end
end
