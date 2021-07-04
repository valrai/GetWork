defmodule GetworkWeb.PhoneNumberController do
  use GetworkWeb, :controller

  alias Getwork.PhoneNumbers
  alias Getwork.PhoneNumbers.PhoneNumber

  action_fallback GetworkWeb.FallbackController

  def index(conn, _params) do
    phone_numbers = PhoneNumbers.list_phone_numbers()
    render(conn, "index.json", phone_numbers: phone_numbers)
  end

  def create(conn, %{"phone_number" => phone_number_params}) do
    with {:ok, %PhoneNumber{} = phone_number} <- PhoneNumbers.create_phone_number(phone_number_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", Routes.phone_number_path(conn, :show, phone_number))
      |> render("show.json", phone_number: phone_number)
    end
  end

  def show(conn, %{"id" => id}) do
    phone_number = PhoneNumbers.get_phone_number!(id)
    render(conn, "show.json", phone_number: phone_number)
  end

  def update(conn, %{"id" => id, "phone_number" => phone_number_params}) do
    phone_number = PhoneNumbers.get_phone_number!(id)

    with {:ok, %PhoneNumber{} = phone_number} <- PhoneNumbers.update_phone_number(phone_number, phone_number_params) do
      render(conn, "show.json", phone_number: phone_number)
    end
  end

  def delete(conn, %{"id" => id}) do
    phone_number = PhoneNumbers.get_phone_number!(id)

    with {:ok, %PhoneNumber{}} <- PhoneNumbers.delete_phone_number(phone_number) do
      send_resp(conn, :no_content, "")
    end
  end
end
