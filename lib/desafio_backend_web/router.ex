defmodule DesafioBackendWeb.Router do
  use DesafioBackendWeb, :router

  alias DesafioBackendWeb.AuthPlug

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_live_flash
    plug :put_root_layout, {DesafioBackendWeb.LayoutView, :root}
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  scope "/api", DesafioBackendWeb do
    pipe_through :api
    post "account/create", AccountController, :create
    post "account/login" , AccountController, :login
  end

  scope "/api", DesafioBackendWeb do
    pipe_through [:api, :auth]

    get "/account/balance_current_user", AccountController, :view_balance
    get "/account/show", AccountController, :show
    put "/account/update/:id", AccountController, :update
    delete "/account/delete/:id", AccountController, :delete


    get "/transaction", TransactionController, :show
    post "/transaction/create", TransactionController, :transaction_account
    post "/transaction/filter_by_date", TransactionController, :filter_transaction_by_date
    put "/transaction/:id", TransactionController, :update
    delete "/transaction/:id", TransactionController, :delete
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug :fetch_session
  end

  pipeline :auth do
    plug AuthPlug
  end

  scope "/", DesafioBackendWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  # Other scopes may use custom stacks.
  # scope "/api", DesafioBackendWeb do
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

      live_dashboard "/dashboard", metrics: DesafioBackendWeb.Telemetry
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
