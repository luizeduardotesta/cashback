defmodule Cashback.Rules do
  @moduledoc """
  The Rules context.
  """

  import Ecto.Query, warn: false
  alias Cashback.Repo

  alias Cashback.Rules.Rule

  @doc """
  Returns the list of rules.

  ## Examples

      iex> list()
      [%Rule{}, ...]

  """
  def list do
    Repo.all(Rule)
  end

  @doc """
  Gets a single rule.

  Raises `Ecto.NoResultsError` if the Rule does not exist.

  ## Examples

      iex> get!(123)
      %Rule{}

      iex> get!(456)
      ** (Ecto.NoResultsError)

  """
  def get!(id), do: Repo.get!(Rule, id)

  @doc """
  Creates a rule.

  ## Examples

      iex> create(%{field: value})
      {:ok, %Rule{}}

      iex> create(%{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def create(attrs \\ %{}) do
    %Rule{}
    |> Rule.changeset(attrs)
    |> Repo.insert()
  end

  @doc """
  Updates a rule.

  ## Examples

      iex> update(rule, %{field: new_value})
      {:ok, %Rule{}}

      iex> update(rule, %{field: bad_value})
      {:error, %Ecto.Changeset{}}

  """
  def update(%Rule{} = rule, attrs) do
    rule
    |> Rule.changeset(attrs)
    |> Repo.update()
  end

  @doc """
  Deletes a rule.

  ## Examples

      iex> delete(rule)
      {:ok, %Rule{}}

      iex> delete(rule)
      {:error, %Ecto.Changeset{}}

  """
  def delete(%Rule{} = rule) do
    Repo.delete(rule)
  end

  @doc """
  Returns an `%Ecto.Changeset{}` for tracking rule changes.

  ## Examples

      iex> change(rule)
      %Ecto.Changeset{data: %Rule{}}

  """
  def change(%Rule{} = rule, attrs \\ %{}) do
    Rule.changeset(rule, attrs)
  end
end
