defmodule GetworkWeb.SkillView do
  use GetworkWeb, :view
  alias GetworkWeb.SkillView

  def render("index.json", %{skill: skill}) do
    %{data: render_many(skill, SkillView, "skill.json")}
  end

  def render("show.json", %{skill: skill}) do
    %{data: render_one(skill, SkillView, "skill.json")}
  end

  def render("skill.json", %{skill: skill}) do
    %{id: skill.id,
      name: skill.name}
  end
end
