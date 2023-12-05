# frozen_string_literal: true
require_relative '../product'

class CoffeeProduct < Product
  def discount(quantity)
    return 0.0 if quantity < 3

    discount = 1.0 / 3.0
    @price * quantity * discount
  end
end
