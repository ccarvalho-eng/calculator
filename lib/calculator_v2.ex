defmodule CalculatorV2 do
  @moduledoc """
  A calculator implementation using command/event pattern.

  This module provides functions to handle calculator commands 
  and their corresponding events for basic arithmetic operations.
  """

  @type state :: %{value: number()}
  @type command :: %{cmd: atom(), value: number()}
  @type event :: %{event_type: atom(), value: number()}

  @doc """
  Handles a command and produces an event.

  ## Parameters
    - state: Current state with value
    - command: Add command with value

  ## Returns
    - An event and a value.
  """
  @spec handle_command(state(), command()) :: event()
  def handle_command(%{value: _val}, %{cmd: :add, value: v}) do
    %{event_type: :value_added, value: v}
  end

  def handle_command(%{value: _val}, %{cmd: :sub, value: v}) do
    %{event_type: :value_subtracted, value: v}
  end

  def handle_command(%{value: _val}, %{cmd: :mul, value: v}) do
    %{event_type: :value_multiplied, value: v}
  end

  def handle_command(%{value: _val}, %{cmd: :div, value: v}) do
    %{event_type: :value_divided, value: v}
  end

  @doc """
  Applies an event to the current state.

  ## Parameters
    - state: Current state with value
    - event: The event with a value

  ## Returns
    - Updated state with the new value
  """
  @spec handle_event(state(), event()) :: state()
  def handle_event(%{value: val}, %{event_type: :value_added, value: v}) do
    %{value: val + v}
  end

  def handle_event(%{value: val}, %{event_type: :value_subtracted, value: v}) do
    %{value: val - v}
  end

  def handle_event(%{value: val}, %{event_type: :value_multiplied, value: v}) do
    %{value: val * v}
  end

  def handle_event(%{value: val}, %{event_type: :value_divided, value: v}) do
    %{value: val / v}
  end
end
