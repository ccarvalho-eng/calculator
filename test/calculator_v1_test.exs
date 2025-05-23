defmodule CalculatorV1Test do
  use ExUnit.Case
  doctest CalculatorV1

  describe "handle_command/2" do
    test "adds two numbers" do
      state = %{value: 5}
      command = %{cmd: :add, value: 3}
      assert CalculatorV1.handle_command(state, command) == %{value: 8}
    end

    test "subtracts two numbers" do
      state = %{value: 10}
      command = %{cmd: :sub, value: 4}
      assert CalculatorV1.handle_command(state, command) == %{value: 6}
    end

    test "multiplies two numbers" do
      state = %{value: 7}
      command = %{cmd: :mul, value: 3}
      assert CalculatorV1.handle_command(state, command) == %{value: 21}
    end

    test "divides two numbers" do
      state = %{value: 15}
      command = %{cmd: :div, value: 3}
      assert CalculatorV1.handle_command(state, command) == %{value: 5.0}
    end

    test "raises an error when dividing by zero" do
      state = %{value: 10}
      command = %{cmd: :div, value: 0}

      assert_raise ArithmeticError, "Division by zero", fn ->
        CalculatorV1.handle_command(state, command)
      end
    end
  end
end
