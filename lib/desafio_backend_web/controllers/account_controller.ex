defmodule DesafioBackendWeb.AccountController do
  use DesafioBackendWeb, :controller

  alias DesafioBackendWeb.Token

  def show(conn, __params) do
    conn
    |> put_status(:ok)
    |> render("index.json", account: DesafioBackend.Account.get_all())
  end

  def create(conn, __params) do
    case DesafioBackend.Account.insert(conn.body_params) do
      {:ok, account} ->
        conn
        |> put_status(:created)
        |> render("account.json", account: account)

      {:error, _changeset} ->
        conn
        |> put_status(:bad_request)
        |> json(%{message: "invalid_data"})
    end
  end

  def view_balance(conn, _params) do
    current_id = get_session(conn, :current_account_id)
    account = DesafioBackend.Account.find_by_id(current_id)
    conn
    |> render("balance.json",account: account)
  end


  def login(conn, _params) do
    case DesafioBackend.AccountAuth.authenticate_account(conn.body_params) do
      {:ok, account} ->
        conn
        |> put_session(:current_account_id, account.id)
        |> configure_session(renew: true)
        |> put_status(:ok)
        |> put_view(DesafioBackendWeb.AccountAuthView)
        |> render("login.json",account: account, token: Token.create(account))

      {:error, message} ->
        conn
        |> delete_session(:current_account_id)
        |> put_status(:unauthorized)
        |> put_view(DesafioBackendWeb.AccountAuthView)
        |> render("401.json",message: message)
    end
  end


  def update(conn, %{"id" => id}) do
    case DesafioBackend.Account.update(String.to_integer(id), conn.body_params) do
      {:ok, _account} ->
        resp(conn, :ok, "")

      {:error, :not_found} ->
        resp(conn, :not_found, "")
    end
  end

  def delete(conn, %{"id" => id}) do
    case DesafioBackend.Account.delete(id) do
      {:ok, _account} ->
        resp(conn, :ok, "")

      {:error, :not_found} ->
        resp(conn, :not_found, "")
    end
  end
end
