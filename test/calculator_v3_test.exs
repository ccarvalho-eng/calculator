defmodule CalculatorV3Test do
  use ExUnit.Case
  doctest CalculatorV3

  describe "handle_command/2 with add command" do
    test "creates add event with exact value when result is within bounds" do
      state = %{value: 5000}
      command = %{cmd: :add, value: 1000}

      assert CalculatorV3.handle_command(state, command) ==
               %{event_type: :value_added, value: 1000}
    end

    test "limits add event value when result would exceed maximum" do
      state = %{value: 9500}
      command = %{cmd: :add, value: 1000}

      # Maximum is 10_000, so we should only add 500
      assert CalculatorV3.handle_command(state, command) ==
               %{event_type: :value_added, value: 500}
    end

    test "handles add event with zero value" do
      state = %{value: 5000}
      command = %{cmd: :add, value: 0}

      assert CalculatorV3.handle_command(state, command) ==
               %{event_type: :value_added, value: 0}
    end
  end

  describe "handle_command/2 with subtract command" do
    test "creates subtract event with exact value when result is within bounds" do
      state = %{value: 5000}
      command = %{cmd: :sub, value: 1000}

      assert CalculatorV3.handle_command(state, command) ==
               %{event_type: :value_subtracted, value: 4000}
    end

    test "creates subtract event with minimum value when result goes below minimum" do
      state = %{value: 500}
      command = %{cmd: :sub, value: 1000}

      # Minimum is 0, so we would just subtract all the way to minimum
      assert CalculatorV3.handle_command(state, command) ==
               %{event_type: :value_subtracted, value: 0}
    end

    test "handles subtract event with zero value" do
      state = %{value: 5000}
      command = %{cmd: :sub, value: 0}

      assert CalculatorV3.handle_command(state, command) ==
               %{event_type: :value_subtracted, value: 5000}
    end
  end

  describe "handle_command/2 with multiply command" do
    test "creates multiply event when result is within bounds" do
      state = %{value: 100}
      command = %{cmd: :mul, value: 10}

      assert CalculatorV3.handle_command(state, command) ==
               %{event_type: :value_multiplied, value: 10}
    end

    test "returns error when multiplication would exceed maximum value" do
      state = %{value: 5000}
      command = %{cmd: :mul, value: 3}

      # 5000 * 3 = 15000 which exceeds maximum of 10_000
      assert CalculatorV3.handle_command(state, command) ==
               {:error, :mul_failed}
    end

    test "handles multiplication by zero" do
      state = %{value: 5000}
      command = %{cmd: :mul, value: 0}

      assert CalculatorV3.handle_command(state, command) ==
               %{event_type: :value_multiplied, value: 0}
    end
  end

  describe "handle_command/2 with divide command" do
    test "creates divide event for valid divisor" do
      state = %{value: 100}
      command = %{cmd: :div, value: 10}

      assert CalculatorV3.handle_command(state, command) ==
               %{event_type: :value_divided, value: 10}
    end

    test "returns error for division by zero" do
      state = %{value: 100}
      command = %{cmd: :div, value: 0}

      assert CalculatorV3.handle_command(state, command) ==
               {:error, :divide_failed}
    end
  end

  describe "handle_event/2" do
    test "adds value to state" do
      state = %{value: 100}
      event = %{event_type: :value_added, value: 50}

      assert CalculatorV3.handle_event(state, event) == %{value: 150}
    end

    test "subtracts value from state" do
      state = %{value: 100}
      event = %{event_type: :value_subtracted, value: 50}

      assert CalculatorV3.handle_event(state, event) == %{value: 50}
    end

    test "multiplies state value by event value" do
      state = %{value: 10}
      event = %{event_type: :value_multiplied, value: 5}

      assert CalculatorV3.handle_event(state, event) == %{value: 50}
    end

    test "divides state value by event value" do
      state = %{value: 100}
      event = %{event_type: :value_divided, value: 5}

      assert CalculatorV3.handle_event(state, event) == %{value: 20.0}
    end

    test "returns unchanged state for unrecognized event" do
      state = %{value: 100}
      event = %{event_type: :unknown_event, value: 50}

      assert CalculatorV3.handle_event(state, event) == %{value: 100}
    end

    test "returns unchanged state for non-map event" do
      state = %{value: 100}
      event = "not an event"

      assert CalculatorV3.handle_event(state, event) == %{value: 100}
    end
  end

  describe "complete command-event workflow" do
    test "add workflow respects maximum value" do
      # Starting near maximum
      state = %{value: 9800}
      command = %{cmd: :add, value: 500}

      event = CalculatorV3.handle_command(state, command)
      assert event == %{event_type: :value_added, value: 200}

      new_state = CalculatorV3.handle_event(state, event)
      assert new_state == %{value: 10000}
    end

    test "subtract workflow respects minimum value" do
      # Starting near minimum
      state = %{value: 100}
      command = %{cmd: :sub, value: 500}

      event = CalculatorV3.handle_command(state, command)
      assert event == %{event_type: :value_subtracted, value: 0}

      new_state = CalculatorV3.handle_event(state, event)
      assert new_state == %{value: 100}
    end

    test "multiplication workflow fails when exceeding maximum" do
      state = %{value: 5000}
      command = %{cmd: :mul, value: 3}

      result = CalculatorV3.handle_command(state, command)
      assert result == {:error, :mul_failed}
    end

    test "division workflow fails with division by zero" do
      state = %{value: 100}
      command = %{cmd: :div, value: 0}

      result = CalculatorV3.handle_command(state, command)
      assert result == {:error, :divide_failed}
    end

    test "successful division workflow" do
      state = %{value: 100}
      command = %{cmd: :div, value: 4}

      event = CalculatorV3.handle_command(state, command)
      assert event == %{event_type: :value_divided, value: 4}

      new_state = CalculatorV3.handle_event(state, event)
      assert new_state == %{value: 25.0}
    end
  end
end
