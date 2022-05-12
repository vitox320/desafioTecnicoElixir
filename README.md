# DesafioBackend

To start your Phoenix server:

  * Install dependencies with `mix deps.get`
  * Run migrations with `mix ecto.migrate`
  * Create and migrate your database with `mix ecto.setup`
  * Start Phoenix endpoint with `mix phx.server` or inside IEx with `iex -S mix phx.server`

## Documentation API

  ### Method: POST: 
    * `http://localhost:4000/api/account/create/`: -> Criar usuário
      - `name`: `name`
      - `surname`: `surname`
      - `email` : `email`
      - `cpf` : `123456`
      - `initial_balance` : `700`
      - `password`: `password`

  ### Method: POST:
    * `http://localhost:4000/api/account/login`: -> Login
      - `email` : `email123@gmail.com`
      - `password` : `12345`

  ### Method: POST:
    * `http://localhost:4000/api/transaction/create` -> Criar conta 
      - `transaction_value` : `100.0,`
      - `identity_receiving_account` : `2`

  ### Method: POST:
    * `http://localhost:4000/api/transaction/filter_by_date` -> Busca transações de por data 
       - `initial_date`: `01/01/2022`
       - `end_date` : `01/02/2023`

  ### Method: GET: 
    * `http://localhost:4000/api/account/show` -> Listagem de account

  ### Method: GET: 
    * `http://localhost:4000/api/transaction` -> Listagem de transações 

  ### Method: GET:
    * `http://localhost:4000/api/account/balance_current_user` -> Visualização de saldo 

 
    


Now you can visit [`localhost:4000`](http://localhost:4000) from your browser.

Ready to run in production? Please [check our deployment guides](https://hexdocs.pm/phoenix/deployment.html).

## Learn more

  * Official website: https://www.phoenixframework.org/
  * Guides: https://hexdocs.pm/phoenix/overview.html
  * Docs: https://hexdocs.pm/phoenix
  * Forum: https://elixirforum.com/c/phoenix-forum
  * Source: https://github.com/phoenixframework/phoenix
