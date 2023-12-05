# frozen_string_literal: true

class ProductNotFound < StandardError
end

class InstructionTest
  attr_reader :available_products

  def initialize(available_products:)
    @available_products = available_products
    @cart = []
  end

  def add_product(product_code, quantity)
    product = @available_products.find { |e| e.code.downcase == product_code }

    raise ProductNotFound, "Product with code '#{product_code}' not found" if product.nil?

    checkout_item = @cart.find { |e| e[:product].code.downcase == product_code }
    if checkout_item
      checkout_item[:quantity] += quantity
    else
      @cart.append(product:, quantity:)
    end
  end

  def to_s
    basket = @cart.flat_map { |e| [e[:product].code] * e[:quantity] }.join(',')

    total_price = @cart.sum do |shooping_item|
      shooping_item[:product].final_price(shooping_item[:quantity])
    end

    "| Basket | Total Price Expected |\n| #{basket} | #{total_price}€ |"
  end
end
