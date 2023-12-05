# frozen_string_literal: true
require_relative '../product'

class StrawberryProduct < Product
  def discount(quantity)
    return 0.0 if quantity < 3

    discount = 0.1
    @price * quantity * discount
  end
end
