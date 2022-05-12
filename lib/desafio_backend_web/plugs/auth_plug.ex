defmodule DesafioBackendWeb.AuthPlug do
  import Plug.Conn

  alias Phoenix.Controller
  alias DesafioBackendWeb.Token

  def init(opts), do: opts

  def call(conn, _opts) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, %{account_id: account_id}} <- Token.verify(token) do
      assign(conn, :account_id, account_id)
    else
      [] -> handle_error(conn)
      {:error, _reason} -> handle_error(conn)
    end
  end

  defp handle_error(conn) do
    conn
    |> put_status(:unauthorized)
    |> Controller.put_view(DesafioBackendWeb.ErrorView)
    |> Controller.render("401.json")
    |> halt()
  end
end
