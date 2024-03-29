defmodule CashbackWeb.PurchaseView do
  use CashbackWeb, :view

  alias Cashback.Purchases
  alias Cashback.Repo

  def render("show.json", %{purchase: purchase}) do
    %{data: render_one(purchase, __MODULE__, "purchase.json")}
  end

  def render("purchase.json", %{purchase: purchase}) do
    purchase = Repo.preload(purchase, :rule)

    %{
      price: purchase.price,
      user_cpf: purchase.user_cpf,
      rule_id: purchase.rule_id,
      id: purchase.id,
      rule_description: purchase.rule.description,
      cashback: Purchases.calc_cashback(purchase.price, purchase.rule.bonus)
    }
  end

  def render("index.json", %{purchases: purchases}) do
    %{data: render_many(purchases, __MODULE__, "purchase.json")}
  end

  def render("code.json", %{purchase: purchase}) do
    purchase = Repo.preload(purchase, :rule)

    %{
      data: %{
        value: Purchases.calc_cashback(purchase.price, purchase.rule.bonus),
        code: Purchases.gen_code(purchase.id, purchase.user_cpf)
      }
    }
  end
end
