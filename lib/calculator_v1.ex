defmodule CalculatorV1 do
  @moduledoc """
  A simple calculator module that handles basic arithmetic operations.

  This module provides functionality to perform addition, subtraction,
  multiplication, and division operations on numeric values.
  """

  @typedoc """
  State of the calculator containing the current value
  """
  @type state :: %{value: number()}

  @typedoc """
  Command to be executed by the calculator
  """
  @type command :: %{cmd: atom(), value: number()}

  @doc """
  Handles the addition command.

  ## Parameters
    - state: Current calculator state with value
    - command: Command with operation and value to add

  ## Returns
    - Updated calculator state
  """
  @spec handle_command(state(), %{cmd: :add, value: number()}) :: state()
  def handle_command(%{value: val}, %{cmd: :add, value: v}) do
    %{value: val + v}
  end

  @spec handle_command(state(), %{cmd: :sub, value: number()}) :: state()
  def handle_command(%{value: val}, %{cmd: :sub, value: v}) do
    %{value: val - v}
  end

  @spec handle_command(state(), %{cmd: :mul, value: number()}) :: state()
  def handle_command(%{value: val}, %{cmd: :mul, value: v}) do
    %{value: val * v}
  end

  @spec handle_command(state(), %{cmd: :div, value: number()}) :: state()
  def handle_command(%{value: val}, %{cmd: :div, value: v}) do
    if v == 0 do
      raise ArithmeticError, message: "Division by zero"
    else
      %{value: val / v}
    end
  end
end
