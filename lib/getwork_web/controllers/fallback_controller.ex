defmodule GetworkWeb.FallbackController do
  @moduledoc """
  Translates controller action results into valid `Plug.Conn` responses.
  See `Phoenix.Controller.action_fallback/1` for more details.
  """
  use GetworkWeb, :controller

  # This clause handles errors returned by Ecto's insert/update/delete.
  def call(conn, {:error, %Ecto.Changeset{} = changeset}) do
    conn
    |> put_status(:unprocessable_entity)
    |> put_view(ApiWeb.ChangesetView)
    |> render("error.json", changeset: changeset)
  end

  def call(conn, {:error, status_code, message}) do
    atom_status =
      status_code
      |> Integer.to_string()
      |> String.to_atom()

    conn
    |> put_status(status_code)
    |> put_view(ApiWeb.ErrorView)
    |> render(atom_status, %{message: message})
  end

  def call(conn, {:error, 401}) do
    call(conn, {:error, 401, "Login Error"})
  end

  def call(conn, {:error, status}) do
    message = Phoenix.Controller.status_message_from_template(status)
    call(conn, {:error, status, message})
  end
end
