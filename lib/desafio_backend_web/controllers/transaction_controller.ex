defmodule DesafioBackendWeb.TransactionController do
  use DesafioBackendWeb, :controller
  alias DesafioBackend.Repo
  alias DesafioBackend.Account
  import Ecto.Query

  def show(conn, __params) do
    conn
    |> put_status(:ok)
    |> render("index.json", transaction: DesafioBackend.Transaction.get_all())
  end

  def transaction_account(conn, _params) do
    current_id = get_session(conn, :current_account_id)
    receive_id = conn.body_params["identity_receiving_account"]
    transaction_value = conn.body_params["transaction_value"]

    Repo.transaction(fn ->
      identity_sender_account = Account.find_by_id(current_id)
      receiving_account = Account.find_by_id(receive_id)

      if identity_sender_account.initial_balance < transaction_value,
        do:
          conn
          |> put_status(:bad_request)
          |> json(%{message: "Saldo insuficiente!"})

      identity_sender_account
      |> Account.changeset(%{
        initial_balance:
          identity_sender_account.initial_balance - conn.body_params["transaction_value"]
      })
      |> Repo.update!()

      receiving_account
      |> Account.changeset(%{
        initial_balance: receiving_account.initial_balance + conn.body_params["transaction_value"]
      })
      |> Repo.update!()

      case DesafioBackend.Transaction.insert(conn.body_params, current_id) do
        {:ok, transaction} ->
          conn
          |> put_status(:created)
          |> render("transaction.json", transaction: transaction, params: conn.body_params)

        {:error, _changeset} ->
          Repo.rollback(:error_create_transaction)

          conn
          |> put_status(:bad_request)
          |> json(%{message: "invalid_data"})
      end
    end)
  end

  def filter_transaction_by_date(conn, _params) do
    start_date = conn.body_params["initial_date"]
    end_date = conn.body_params["end_date"]

    initial_date = DesafioBackend.Util.date_br_to_datetime(start_date)
    final_date = DesafioBackend.Util.date_br_to_datetime(end_date)

    transaction =
      from(transact in DesafioBackend.Transaction,
        where:
          transact.data_processing >= ^initial_date and transact.data_processing <= ^final_date
      )
      |> Repo.all()

    conn
    |> render("index.json", transaction: transaction)
  end

  def update(conn, %{"id" => id}) do
    case DesafioBackend.Transaction.update(String.to_integer(id), conn.body_params) do
      {:ok, _transaction} ->
        resp(conn, :ok, "")

      {:error, :not_found} ->
        resp(conn, :not_found, "")
    end
  end

  def delete(conn, %{"id" => id}) do
    case DesafioBackend.Transaction.delete(id) do
      {:ok, _transaction} ->
        resp(conn, :ok, "")

      {:error, :not_found} ->
        resp(conn, :not_found, "")
    end
  end
end
