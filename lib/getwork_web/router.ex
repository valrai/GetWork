defmodule GetworkWeb.Router do
  use GetworkWeb, :router
  alias GetworkWeb.Auth.BasicAuthPlug

  pipeline :api do
    plug :accepts, ["json"]
  end

  pipeline :basic_auth_login do
    plug BasicAuthPlug
  end

  scope "/api/users", GetworkWeb do
    pipe_through :api

    post "/", UserController, :create
    get "/", UserController, :index
    get "/:id", UserController, :show
    delete "/:id", UserController, :delete
    put "/:id", UserController, :update
    put "/suspension/:id", UserController, :suspend_account
  end

  scope "/api", GetworkWeb do
    pipe_through :api

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

  if Mix.env() in [:dev, :test] do
    import Phoenix.LiveDashboard.Router

    # Live Dashboard
    scope "/" do
      # Swagger
      pipe_through :basic_auth_login

      # Live Dashboard
      live_dashboard "/dashboard", metrics: GetworkWeb.Telemetry

      forward "/", PhoenixSwagger.Plug.SwaggerUI,
        otp_app: :getwork,
        swagger_file: "swagger.yml"
    end
  end
end
