defmodule GetworkWeb.AddressView do
  use GetworkWeb, :view
  alias GetworkWeb.AddressView

  def render("index.json", %{addresses: addresses}) do
    %{data: render_many(addresses, AddressView, "address.json")}
  end

  def render("show.json", %{address: address}) do
    %{data: render_one(address, AddressView, "address.json")}
  end

  def render("address.json", %{address: address}) do
    %{id: address.id,
      zip_code: address.zip_code,
      state: address.state,
      city: address.city,
      address_line_one: address.address_line_one,
      address_line_two: address.address_line_two}
  end
end
