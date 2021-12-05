defmodule CashbackWeb.PurchaseControllerTest do

  use CashbackWeb.ConnCase

  import Cashback.PurchasesFixtures

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "create/2" do
    test "returns a purchase when valid data", %{conn: conn} do
      rule = Cashback.RulesFixtures.rule_fixture()
      params = %{price: 42, user_cpf: "some user_cpf", rule_id: rule.id}

      conn = post(conn, Routes.purchase_path(conn, :create), purchase: params)

      assert subject = json_response(conn, 201)["data"]
      assert subject["price"] == params.price
      assert subject["user_cpf"] == params.user_cpf
      assert subject["rule_id"] == params.rule_id
      assert is_nil(subject["id"]) == false
      assert subject["rule_description"] == rule.description
      assert subject["cashback"] == (params.price * (rule.bonus / 100))
    end
  end

  test "returns error when invalid data", %{conn: conn} do
    params = %{price: 42, user_cpf: "", rule_id: Cashback.RulesFixtures.rule_fixture().id}

    conn = post(conn, Routes.purchase_path(conn, :create), purchase: params)

    assert _subject = json_response(conn, 422)
  end
end
