# frozen_string_literal: true

require_relative '../command'

class ListStoreCommand < Command
  def initialize(keybind:, description:, products:, output:)
    @products = products
    @output = output
    super(keybind:, description:)
  end

  def perform(_)
    @output.call 'a <product_code> <quantity>'
    @output.call @products
  end

  def list_products
    header = '| Product Code | Name | Price |'
    [header, @products].join("\n")
  end
end
