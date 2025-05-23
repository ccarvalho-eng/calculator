defmodule Calculator do
  @moduledoc """
  Provides basic arithmetic operations.

  This module implements common mathematical operations like addition,
  subtraction, multiplication, and division for numbers.
  """
  @doc """
  Adds two numbers together.

  ## Examples

      iex> Calculator.add(1, 2)
      3

      iex> Calculator.add(5.5, 4.5)
      10.0
  """
  @spec add(number(), number()) :: number()
  def add(x, y) do
    x + y
  end

  @doc """
  Multiplies two numbers together.

  ## Examples

      iex> Calculator.mul(2, 3)
      6

      iex> Calculator.mul(2.5, 2)
      5.0
  """
  @spec mul(number(), number()) :: number()
  def mul(x, y) do
    x * y
  end

  @doc """
  Divides the first number by the second number.

  ## Examples

      iex> Calculator.div(6, 2)
      3.0

      iex> Calculator.div(5, 2)
      2.5
  """
  @spec div(number(), number()) :: float()
  def div(x, y) do
    x / y
  end

  @doc """
  Subtracts the second number from the first number.

  ## Examples

      iex> Calculator.sub(5, 2)
      3

      iex> Calculator.sub(10.5, 0.5)
      10.0
  """
  @spec sub(number(), number()) :: number()
  def sub(x, y) do
    x - y
  end
end
