defmodule MovieNightWeb.MovieEndpointController do
    use MovieNightWeb, :controller

    def create(conn, params) do
        json conn, params
    end
end