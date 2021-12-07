defmodule CashbackWeb.PurchaseControllerTest do

  use CashbackWeb.ConnCase

  import Cashback.PurchasesFixtures

  alias Cashback.Purchases

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

  describe "index/2" do
    setup %{conn: conn} do
      {:ok, conn: conn, purchase: purchase_fixture()}
    end

    test "returns a list of rules when valid data", %{conn: conn, purchase: purchase} do
      purchase = Cashback.Repo.preload(purchase, :rule)
      conn = get(conn, Routes.purchase_path(conn, :index))

      assert [subject] = json_response(conn, 200)["data"]
      assert subject["id"] == purchase.id
      assert subject["price"] == purchase.price
      assert subject["user_cpf"] == purchase.user_cpf
      assert subject["rule_id"] == purchase.rule_id
      assert subject["rule_description"] == purchase.rule.description
      assert subject["cashback"] == Purchases.calc_cashback(purchase.price, purchase.rule.bonus)
    end
  end

  describe "cashback_code/2" do
    setup %{conn: conn} do
      {:ok, conn: conn, purchase: purchase_fixture()}
    end

    test "returns a caskback's code when valid data", %{conn: conn, purchase: purchase} do
      code = :crypto.hash(:md5, "#{purchase.id} #{purchase.user_cpf}") |> Base.encode16()
      purchase = Cashback.Repo.preload(purchase, :rule)

      conn = post(conn, "api/cashback_code/#{purchase.id}")

      assert subject = json_response(conn, 201)["data"]
      assert subject["value"] == Purchases.calc_cashback(purchase.price, purchase.rule.bonus)
      assert subject["code"] == code
    end
  end
end
