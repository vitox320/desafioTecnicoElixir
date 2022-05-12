# DesafioBackend

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Run migrations with `mix ecto.migrate`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

## Documentation API

  Create Account: `http://localhost:4000/api/account/create/`: -> Criar usuário -> POST
    * `name`: `name`
    * `surname`: `surname`
    * `email` : `email`
    * `cpf` : `123456`
    * `initial_balance` : `700`
    * `password`: `password`

  Login: `http://localhost:4000/api/account/login`: -> Login -> POST
    * `email` : `zaaw320@gmail.com`
    * `password` : `12345`

  Show: `http://localhost:4000/api/account/show` -> Listagem de account -> GET

  create: `http://localhost:4000/api/transaction/create` -> Criar conta -> POST
    * `transaction_value` : `100.0,`
    * `identity_receiving_account` : `2`

  Transaction: `http://localhost:4000/api/transaction` -> Listagem de transações -> GET

  Balance Current User: `http://localhost:4000/api/account/balance_current_user` -> Visualização de saldo -> GET

  Filter_by_date: `http://localhost:4000/api/transaction/filter_by_date` -> Busca transações de por data -> POST
     * `initial_date`: `01/01/2022`
     * `end_date` : `01/02/2023`
    


Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
