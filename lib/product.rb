# frozen_string_literal: true

class Product
  attr_reader :code, :price

  def initialize(code:, name:, price:)
    @code = code
    @name = name
    @price = price
  end

  def discount(_quantity)
    0
  end

  def final_price(quantity = 1)
    (price * quantity - discount(quantity)).round(2)
  end

  def to_s
    "| #{@code} | #{@name} | #{@price}€ |"
  end
end
