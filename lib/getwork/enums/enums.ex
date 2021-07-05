defmodule Getwork.Enums do
  @moduledoc """
  GetWork enumerations
  """
  import EctoEnum

  def work_experience_type_values,
    do: [
      :personal_project,
      :own_business,
      :startup,
      :small_company,
      :medium_sized_company,
      :big_company,
      "personal_project",
      "own_business",
      "startup",
      "small_company",
      "medium_sized_company",
      "big_company"
    ]

  defenum(WorkExperienceType, :work_experience_type, [
    :personal_project,
    :own_business,
    :startup,
    :small_company,
    :medium_sized_company,
    :big_company
  ])
end
