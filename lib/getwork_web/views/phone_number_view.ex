defmodule GetworkWeb.PhoneNumberView do
  use GetworkWeb, :view
  alias GetworkWeb.PhoneNumberView

  def render("index.json", %{phone_numbers: phone_numbers}) do
    %{data: render_many(phone_numbers, PhoneNumberView, "phone_number.json")}
  end

  def render("show.json", %{phone_number: phone_number}) do
    %{data: render_one(phone_number, PhoneNumberView, "phone_number.json")}
  end

  def render("phone_number.json", %{phone_number: phone_number}) do
    %{id: phone_number.id,
      phone: phone_number.phone}
  end
end
