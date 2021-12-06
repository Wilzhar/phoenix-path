defmodule PhoenixPathWeb.Router do
  use PhoenixPathWeb, :router

  pipeline :browser do
    plug :accepts, ["html", "text"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {PhoenixPathWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug PhoenixPathWeb.Plugs.Locale, "en"
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", PhoenixPathWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/json/many", PageController, :show_json_many
    get "/json/one", PageController, :show_json_one
    get "/hello", HelloController, :index
    get "/hello/:messenger", HelloController, :show
    get "/redirect_test", PageController, :redirect_test
    get "/test", PageController, :test

    resources "/users", UserController do
      resources "/posts", PostController
    end

    resources "/posts", PostController, only: [:index, :show]
    resources "/comments", CommentController, except: [:delete]
    resources "/reviews", ReviewController
  end

  scope "/admin", PhoenixPathWeb.Admin, as: :admin do
    pipe_through :browser

    resources "/images", ImageController
    resources "/reviews", ReviewController
    resources "/users", UserController
  end

  scope "/api", PhoenixPathWeb.Api, as: :api do
    pipe_through :api

    scope "/v1", V1, as: :v1 do
      resources "/images", ImageController
      resources "/reviews", ReviewController
      resources "/users", UserController
    end
  end

  # Other scopes may use custom stacks.
  # scope "/api", PhoenixPathWeb do
  #   pipe_through :api
  # end

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
      pipe_through :browser
      live_dashboard "/dashboard", metrics: PhoenixPathWeb.Telemetry
    end
  end

  # Enables the Swoosh mailbox preview in development.
  #
  # Note that preview only shows emails that were sent by the same
  # node running the Phoenix server.
  if Mix.env() == :dev do
    scope "/dev" do
      pipe_through :browser

      forward "/mailbox", Plug.Swoosh.MailboxPreview
    end
  end
end
