defmodule DesafioBackend.Account do
  use Ecto.Schema
  alias DesafioBackend.Repo

  import Ecto.Changeset

  schema "accounts" do
    field :name, :string
    field :surname, :string
    field :cpf, :string
    field :email, :string
    field :initial_balance, :float
    field :date_create, :string
    field :password, :string, virtual: true
    field :password_hash, :string


  end

  def changeset(account, params \\ %{}) do
    account
    |> cast(params, [:name, :surname, :cpf,:email, :initial_balance, :date_create, :password])
    |> validate_required([:name, :surname, :email ,:cpf, :initial_balance, :date_create])
    |> unique_constraint(:email)
    |> put_password_hash()
  end

  defp put_password_hash(
         %Ecto.Changeset{valid?: true, changes: %{password: password}} = changeset
       ) do
    change(changeset, Bcrypt.add_hash(password))
  end

  defp put_password_hash(changeset) do
    changeset
  end

  def get_all(), do: Repo.all(DesafioBackend.Account)

  def find_by_id(id), do: Repo.get(DesafioBackend.Account, id)

  def insert(account) do
    current_date = :calendar.local_time |> NaiveDateTime.from_erl!() |> DateTime.from_naive!("Etc/UTC") |> DateTime.to_string()
    %DesafioBackend.Account{date_create: current_date}
    |> changeset(account)
    |> Repo.insert()
  end

  def update(id, data) do
    case find_by_id(id) do
      nil ->
        {:error, :not_found}

        account ->
          account
          |> changeset(data)
          |> Repo.update()
    end
  end

  def delete(id) do
    case find_by_id(id) do
      nil ->
        {:error, :not_found}

      account ->
        Repo.delete(account)
    end
  end


end
