# frozen_string_literal: true
require_relative '../command'

class AddItemCommand < Command
  def initialize(keybind:, description:, cart:, output:)
    @cart = cart
    @output = output
    super(keybind:, description:)
  end

  def perform(instruction_list)
    product_code = get_product_code(instruction_list)
    quantity = get_quantity(instruction_list)
    @cart.add_product(product_code, quantity)
    @output.call @cart
  end
end
