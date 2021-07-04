defmodule GetworkWeb.CompanyView do
  use GetworkWeb, :view
  alias GetworkWeb.CompanyView

  def render("index.json", %{companies: companies}) do
    %{data: render_many(companies, CompanyView, "company.json")}
  end

  def render("show.json", %{company: company}) do
    %{data: render_one(company, CompanyView, "company.json")}
  end

  def render("company.json", %{company: company}) do
    %{id: company.id,
      ein: company.ein,
      name: company.name,
      trade_name: company.trade_name,
      link: company.link,
      picture_ul: company.picture_ul}
  end
end
