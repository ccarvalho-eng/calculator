defmodule CalculatorV2Test do
  use ExUnit.Case
  doctest CalculatorV2

  describe "handle_command/2" do
    test "creates add event" do
      state = %{value: 10}
      command = %{cmd: :add, value: 5}

      assert CalculatorV2.handle_command(state, command) == %{event_type: :value_added, value: 5}
    end

    test "creates subtract event" do
      state = %{value: 10}
      command = %{cmd: :sub, value: 5}

      assert CalculatorV2.handle_command(state, command) == %{
               event_type: :value_subtracted,
               value: 5
             }
    end

    test "creates multiply event" do
      state = %{value: 10}
      command = %{cmd: :mul, value: 5}

      assert CalculatorV2.handle_command(state, command) == %{
               event_type: :value_multiplied,
               value: 5
             }
    end

    test "creates divide event" do
      state = %{value: 10}
      command = %{cmd: :div, value: 5}

      assert CalculatorV2.handle_command(state, command) == %{
               event_type: :value_divided,
               value: 5
             }
    end
  end

  describe "handle_event/2" do
    test "adds value to state" do
      state = %{value: 10}
      event = %{event_type: :value_added, value: 5}

      assert CalculatorV2.handle_event(state, event) == %{value: 15}
    end

    test "subtracts value from state" do
      state = %{value: 10}
      event = %{event_type: :value_subtracted, value: 5}

      assert CalculatorV2.handle_event(state, event) == %{value: 5}
    end

    test "multiplies state by value" do
      state = %{value: 10}
      event = %{event_type: :value_multiplied, value: 5}

      assert CalculatorV2.handle_event(state, event) == %{value: 50}
    end

    test "divides state by value" do
      state = %{value: 10}
      event = %{event_type: :value_divided, value: 5}

      assert CalculatorV2.handle_event(state, event) == %{value: 2.0}
    end
  end

  describe "full command-event cycle" do
    test "add operation full cycle" do
      state = %{value: 10}
      command = %{cmd: :add, value: 5}

      event = CalculatorV2.handle_command(state, command)
      new_state = CalculatorV2.handle_event(state, event)

      assert new_state == %{value: 15}
    end

    test "subtract operation full cycle" do
      state = %{value: 10}
      command = %{cmd: :sub, value: 5}

      event = CalculatorV2.handle_command(state, command)
      new_state = CalculatorV2.handle_event(state, event)

      assert new_state == %{value: 5}
    end

    test "multiply operation full cycle" do
      state = %{value: 10}
      command = %{cmd: :mul, value: 5}

      event = CalculatorV2.handle_command(state, command)
      new_state = CalculatorV2.handle_event(state, event)

      assert new_state == %{value: 50}
    end

    test "divide operation full cycle" do
      state = %{value: 10}
      command = %{cmd: :div, value: 5}

      event = CalculatorV2.handle_command(state, command)
      new_state = CalculatorV2.handle_event(state, event)

      assert new_state == %{value: 2.0}
    end
  end
end
