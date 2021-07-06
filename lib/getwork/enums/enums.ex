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

  def education_level_values,
    do: [
      :none,
      :form3,
      :form5,
      :secondary,
      :form7,
      :associate_degree,
      :bachelors_degree,
      :masters_degree,
      :doctoral_degree,
      :other,
      "none",
      "form3",
      "form5",
      "secondary",
      "form7",
      "associate_degree",
      "bachelors_degree",
      "masters_degree",
      "doctoral_degree",
      "other"
    ]

  defenum(EducationLevel, :education_level, [
    :none,
    :form3,
    :form5,
    :secondary,
    :form7,
    :associate_degree,
    :bachelors_degree,
    :masters_degree,
    :doctoral_degree,
    :other
  ])
end
