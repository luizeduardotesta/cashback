defmodule CashbackWeb.RuleView do
  use CashbackWeb, :view

  def render("show.json", %{rule: rule}) do
    %{data: render_one(rule, __MODULE__, "rule.json")}
  end

  def render("rule.json", %{rule: rule}) do
      %{
      id: rule.id,
      description: rule.description,
      bonus: rule.bonus
    }
  end

  def render("index.json", %{rules: rules}) do
    %{data: render_many(rules, __MODULE__, "rule.json")}
  end
end
