defmodule GetworkWeb.EducationView do
  use GetworkWeb, :view
  alias GetworkWeb.EducationView

  def render("index.json", %{educations: educations}) do
    %{data: render_many(educations, EducationView, "education.json")}
  end

  def render("show.json", %{education: education}) do
    %{data: render_one(education, EducationView, "education.json")}
  end

  def render("education.json", %{education: education}) do
    %{id: education.id,
      type: education.type,
      institution: education.institution,
      city: education.city,
      its_currently_attending: education.its_currently_attending,
      start_date: education.start_date,
      end_date: education.end_date}
  end
end
