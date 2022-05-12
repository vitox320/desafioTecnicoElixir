defmodule DesafioBackend.Transaction do
  use Ecto.Schema
  alias DesafioBackend.Repo

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
