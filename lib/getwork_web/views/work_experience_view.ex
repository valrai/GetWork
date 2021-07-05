defmodule GetworkWeb.WorkExperienceView do
  use GetworkWeb, :view
  alias GetworkWeb.WorkExperienceView

  def render("index.json", %{work_experiences: work_experiences}) do
    %{data: render_many(work_experiences, WorkExperienceView, "work_experience.json")}
  end

  def render("show.json", %{work_experience: work_experience}) do
    %{data: render_one(work_experience, WorkExperienceView, "work_experience.json")}
  end

  def render("work_experience.json", %{work_experience: work_experience}) do
    %{id: work_experience.id,
      company_or_project: work_experience.company_or_project,
      type: work_experience.type,
      job_position: work_experience.job_position,
      current_job: work_experience.current_job,
      start_date: work_experience.start_date,
      end_date: work_experience.end_date,
      description: work_experience.description}
  end
end
