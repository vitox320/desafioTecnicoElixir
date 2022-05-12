defmodule DesafioBackend.Repo.Migrations.CreateAccountTable do
  use Ecto.Migration

  def change do
    create table("accounts") do
      add :name, :string
      add :surname, :string
      add :email, :string, null: false
      add :password_hash, :string
      add :cpf, :string
      add :initial_balance, :float
      add :date_create, :string
    end
  end

end
