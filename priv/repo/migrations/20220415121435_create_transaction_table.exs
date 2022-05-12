defmodule DesafioBackend.Repo.Migrations.CreateTransactionTable do
  use Ecto.Migration

  def change do
    create table("transaction") do
      add :transaction_value, :float
      add :data_processing, :utc_datetime
      add :identity_sender_account, :integer
      add :identity_receiving_account, :integer
    end
  end
end
