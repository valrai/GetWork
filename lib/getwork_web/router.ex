defmodule GetworkWeb.Router do
  use GetworkWeb, :router
  alias GetworkWeb.Auth.BasicAuthPlug

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :basic_auth_login do
    plug BasicAuthPlug
  end

  scope "/api", GetworkWeb do
    pipe_through :api

    resources "/users", UserController
    resources "/claims", ClaimController
    resources "/roles", RoleController
    resources "/addresses", AddressController
    resources "/languages", LanguageController
    resources "/skills", SkillController
    resources "/phone_numbers", PhoneNumberController
    resources "/tags", TagController
    resources "/candidates", CandidateController
    resources "/companies", CompanyController
    resources "/work-experiences", WorkExperienceController
    resources "/education", EducationController
    resources "/job-offers", JobOfferController
  end

  # Enables LiveDashboard only for development
  #
  # If you want to use the LiveDashboard in production, you should put
  # it behind authentication and allow only admins to access it.
  # If your application does not have an admins-only section yet,
  # you can use Plug.BasicAuth to set up some basic authentication
  # as long as you are also using SSL (which you should anyway).
  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    scope "/" do
      pipe_through [:fetch_session, :protect_from_forgery]
      live_dashboard "/dashboard", metrics: GetworkWeb.Telemetry
    end
  end
end
