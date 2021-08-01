defmodule Shared.Helpers.MapHelper do
  @moduledoc """
  Functions to help manipulate Maps.
  """

  @doc """
  Convert map string keys to :atom keys recursively.

  ## Exemples

      iex> Shared.Helpers.MapHelper.atomize_keys(%{"some_key" => :value})
      ${some_key: :value}

      iex> Shared.Helpers.MapHelper.atomize_keys(%{some_key: %{"other_key" => "some value"}})
      %{some_key: %{other_key: "some value"}}

      iex> Shared.Helpers.MapHelper.atomize_keys(%{atom_key: :value})
      %{atom_key: :value}

      iex> Shared.Helpers.MapHelper.atomize_keys(nil)
      nil

  """
  def atomize_keys(nil), do: nil

  def atomize_keys(struct = %{__struct__: _}), do: struct

  def atomize_keys(map = %{}) do
    map
    |> Enum.map(fn
      {k, v} when is_atom(k) -> {k, atomize_keys(v)}
      {k, v} -> {String.to_atom(k), atomize_keys(v)}
    end)
    |> Enum.into(%{})
  end

  def atomize_keys([head | rest]) do
    [atomize_keys(head) | atomize_keys(rest)]
  end

  def atomize_keys(not_a_map) do
    not_a_map
  end

  @doc """
  Convert map atom keys to strings keys recursively

      iex> Shared.Helpers.MapHelper.stringify_keys(%{some_key: :value})
      ${"some_key" => :value}

      iex> Shared.Helpers.MapHelper.stringify_keys(%{"some_key" => %{other_key: "some value"}})
      %{"some_key" => %{"other_key" => "some value"}}

      iex> Shared.Helpers.MapHelper.stringify_keys(%{"string_key" => :value})
      %{"string_key" => :value}

      iex> Shared.Helpers.MapHelper.stringify_keys(nil)
      nil

  """
  def stringify_keys(nil), do: nil

  def stringify_keys(struct) when is_struct(struct) do
    struct
    |> Map.from_struct()
    |> stringify_keys()
  end

  def stringify_keys(map = %{}) do
    map
    |> Enum.map(fn
      {k, v} when is_binary(k) -> {k, stringify_keys(v)}
      {k, v} -> {Atom.to_string(k), stringify_keys(v)}
    end)
    |> Enum.into(%{})
  end

  def stringify_keys([head | rest]), do: [stringify_keys(head) | stringify_keys(rest)]

  def stringify_keys(not_a_map), do: not_a_map
end
