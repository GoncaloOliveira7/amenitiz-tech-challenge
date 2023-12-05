# frozen_string_literal: true
require_relative '../product'

class GreenTeaProduct < Product
  def discount(quantity)
    return 0.0 if quantity < 2

    (quantity / 2).to_i * @price
  end
end
