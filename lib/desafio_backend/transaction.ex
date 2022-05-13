defmodule DesafioBackend.Transaction do
  use Ecto.Schema
  alias DesafioBackend.Repo
  alias DesafioBackend.Account



  import Ecto.Changeset

  schema "transaction" do
    field :transaction_value, :float
    field :data_processing, :utc_datetime
    field :identity_sender_account, :integer
    field :identity_receiving_account, :integer
  end

  def changeset(transaction, params \\ %{}) do
    transaction
    |> cast(params, [
      :transaction_value,
      :data_processing,
      :identity_sender_account,
      :identity_receiving_account
    ])
    |> validate_required([
      :transaction_value,
      :data_processing,
      :identity_sender_account,
      :identity_receiving_account
    ])
  end

  def get_all(), do: Repo.all(DesafioBackend.Transaction)

  def find_by_id(id), do: Repo.get(DesafioBackend.Transaction, id)

  def insert(transaction, id_current_user) do
    current_date = :calendar.local_time |> NaiveDateTime.from_erl!() |> DateTime.from_naive!("Etc/UTC")
    %DesafioBackend.Transaction{identity_sender_account: id_current_user, data_processing: current_date }
    |> changeset(transaction)
    |> Repo.insert()
  end

  def verify_if_balance_is_lower_than_transaction_value(account,transaction_value) do
    if account.initial_balance < transaction_value do
      :true
    else
      :false
    end
  end

  def deposit(account, transaction_value) do
    account
    |> Account.changeset(%{
      initial_balance: account.initial_balance + transaction_value
    })
    |> Repo.update!()
  end

  def withdraw(account, transaction_value) do
    account
    |> Account.changeset(%{
      initial_balance: account.initial_balance - transaction_value
    })
    |> Repo.update!()
  end

  def update(id, data) do
    case find_by_id(id) do
      nil ->
        {:error, :not_found}

      transaction ->
        transaction
        |> changeset(data)
        |> Repo.update()
    end
  end

  def delete(id) do
    case find_by_id(id) do
      nil ->
        {:error, :not_found}

      transaction ->
        Repo.delete(transaction)
    end
  end
end
