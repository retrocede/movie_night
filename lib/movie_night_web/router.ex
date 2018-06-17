defmodule MovieNightWeb.Router do
  use MovieNightWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", MovieNightWeb do
    pipe_through :api
    
    resources "/test", TestEndpointController
    resources "/search", SearchEndpointController
    resources "/movies", MovieEndpointController
  end

  scope "/", MovieNightWeb do
    pipe_through :browser # Use the default browser stack

    get "/*path", PageController, :index
  end
end
