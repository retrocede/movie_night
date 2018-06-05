defmodule MovieNightWeb.TestEndpointController do
    use MovieNightWeb, :controller

    def index(conn, _params) do
        json conn, %{test: 11, data: 42, endpoint: 13}
    end
end