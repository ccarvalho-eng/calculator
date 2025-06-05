defmodule CalculatorV3 do
  @moduledoc """
  An advanced calculator implementation using command/event pattern with boundaries.

  This module provides functions to handle calculator commands and their corresponding events 
  for basic arithmetic operations, while enforcing certain boundaries:
  - Values are kept between `@min_state_value` and `@max_state_value`
  - Division by zero is prevented
  - Multiplication resulting in values exceeding the maximum is prevented
  """

  @max_state_value 10_000
  @min_state_value 0

  @typedoc "State of the calculator with a numeric value"
  @type state :: %{value: number()}

  @typedoc "Command to perform a calculator operation"
  @type command :: %{cmd: atom(), value: number()}

  @typedoc "Event resulting from a successful command"
  @type event :: %{event_type: atom(), value: number()}

  @typedoc "Error response when a command cannot be processed"
  @type error :: {:error, atom()}

  @doc """
  Handles the command and produces an event.

  Ensures the result won't exceed the threshold value.

  ## Parameters
    - state: Current state with value
    - command: Add command with value

  ## Returns
    - An event and adjusted value
  """
  @spec handle_command(state(), command()) :: event()
  def handle_command(%{value: val}, %{cmd: :add, value: v}) do
    %{event_type: :value_added, value: min(@max_state_value - val, v)}
  end

  def handle_command(%{value: val}, %{cmd: :sub, value: v}) do
    %{event_type: :value_subtracted, value: max(@min_state_value, val - v)}
  end

  def handle_command(
        %{value: val},
        %{cmd: :mul, value: v}
      )
      when val * v > @max_state_value do
    {:error, :mul_failed}
  end

  def handle_command(%{value: _val}, %{cmd: :mul, value: v}) do
    %{event_type: :value_multiplied, value: v}
  end

  def handle_command(
        %{value: _val},
        %{cmd: :div, value: 0}
      ) do
    {:error, :divide_failed}
  end

  def handle_command(%{value: _val}, %{cmd: :div, value: v}) do
    %{event_type: :value_divided, value: v}
  end

  @doc """
  Applies an add event to the current state.

  ## Parameters
    - state: Current state with value
    - event: The event with value

  ## Returns
    - Updated state with the new value
  """
  @spec handle_event(state(), event()) :: state()
  def handle_event(
        %{value: val},
        %{event_type: :value_added, value: v}
      ) do
    %{value: val + v}
  end

  def handle_event(
        %{value: val},
        %{event_type: :value_subtracted, value: v}
      ) do
    %{value: val - v}
  end

  def handle_event(
        %{value: val},
        %{event_type: :value_multiplied, value: v}
      ) do
    %{value: val * v}
  end

  def handle_event(
        %{value: val},
        %{event_type: :value_divided, value: v}
      ) do
    %{value: val / v}
  end

  def handle_event(%{value: _val} = state, _) do
    state
  end
end
