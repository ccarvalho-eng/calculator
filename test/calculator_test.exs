defmodule CalculatorTest do
  use ExUnit.Case
  doctest Calculator

  test "add/2 adds two numbers" do
    assert Calculator.add(1, 2) == 3
    assert Calculator.add(5, 5) == 10
    assert Calculator.add(-1, -1) == -2
  end

  test "mul/2 multiplies two numbers" do
    assert Calculator.mul(2, 3) == 6
    assert Calculator.mul(5, 5) == 25
    assert Calculator.mul(-1, -1) == 1
  end

  test "div/2 divides two numbers" do
    assert Calculator.div(6, 3) == 2
    assert Calculator.div(10, 5) == 2
    assert Calculator.div(-4, -2) == 2
  end

  test "sub/2 subtracts two numbers" do
    assert Calculator.sub(5, 3) == 2
    assert Calculator.sub(10, 5) == 5
    assert Calculator.sub(-1, -1) == 0
  end

  test "operations can be chained" do
    assert Calculator.add(1, 2) |> Calculator.mul(3) == 9
    assert Calculator.div(6, 2) |> Calculator.sub(1) == 2
    assert Calculator.mul(2, 3) |> Calculator.add(4) == 10
  end

  test "division by zero raises an error" do
    assert_raise ArithmeticError, fn ->
      Calculator.div(1, 0)
    end
  end
end
