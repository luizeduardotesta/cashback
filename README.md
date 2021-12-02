# Cashback

  Uma api RESTfull.

### Proposal Problem

  Fazer cashback para os cliente. Sistema usado apenas pelo admin. Conforme o trello:
  https://trello.com/b/ORB80QSL/cashback

## Deps for Linux

- `sudo apt update`
- `sudo apt upgrade`
- `sudo apt install -y build-essential libssl-dev zlib1g-dev automake autoconf libncurses5-dev`

## In loco Setup

- Instalar as deps `mix deps.get`
- Criar o banco `mix ecto.setup`
- Start Phoenix  `mix phx.server`
- Rodar os testes `mix test`

## Database
  PostgreSQL
  ```
  username: postgres
  password: postgres
  ```

## Using

 Você pode usar postman/insomnia ou algo similar pra fazer os request de endpoin abaixo:

### Endpoint

 - Cadastrar regras (post `api/rules`)
  ```
  {
    rule: { 
      description: "cashback simples", 
      bonus: 10
    }
  }
  ```

 - Listagem de regras (get `api/rules`)

 - Cadastrar compra do usuario (post `api/purchases`)
  ```
  {
    purchase: { 
      rule_id: 1,
      user_cpf: "466.745.098-20",
      value: 2000
    }
  }
  ```

 - Listagem de compras (get `api/purchases`)

 - Listar cashback por cliente (get `api/cashback`)

## Made by

 - [Luiz Eduardo Testa Santos](https://github.com/luizeduardotesta)