defmodule Cashback.Purchases.Purchase do
  use Ecto.Schema
  import Ecto.Changeset

  schema "purchases" do
    field :price, :integer
    field :user_cpf, :string

    belongs_to :rule, Cashback.Rules.Rule

    timestamps()
  end

  @required [:price, :user_cpf, :rule_id]
  @doc false
  def changeset(purchase, attrs) do
    purchase
    |> cast(attrs, @required)
    |> validate_required(@required)
  end
end
