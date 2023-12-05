# frozen_string_literal: true

require_relative 'products/coffee_product'
require_relative 'products/green_tea_product'
require_relative 'products/strawberry_product'
require_relative 'cart'

PRODUCTS = [
  GreenTeaProduct.new(code: 'GR1', name: 'Green Tea', price: 3.11),
  StrawberryProduct.new(code: 'SR1', name: 'Strawberries', price: 5.00),
  CoffeeProduct.new(code: 'CF1', name: 'Coffee', price: 11.23)
]

INITIAL_PROMPT = "Hello! Welcome to my store!

Options:
  s) store
  c) cart
  q) quit
"

class InvalidInstruction < StandardError
end

class ConsoleInterface
  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
    @cart = Cart.new(available_products: PRODUCTS)
  end

  def run
    console_puts INITIAL_PROMPT
    loop do
      instruction_list = console_gets

      case get_command(instruction_list)
      when 's'
        show_store
      when 'add'
        add_product(instruction_list)
      when 'c'
        show_cart
      when 'q'
        return
      else
        raise InvalidInstruction.new("Instruction '#{get_command(instruction_list)}' not recognized") 
      end
    rescue InvalidInstruction, ProductNotFound => e
      console_puts "Invalid Instruction error: #{e.message}"
      console_puts INITIAL_PROMPT
    end
  end

  def get_command(instruction_list)
    instruction_list.first
  end

  def get_quantity(instruction_list)
    quantity = instruction_list[2]

    raise InvalidInstruction.new("Quantity can't be blank") if quantity.nil?

    raise InvalidInstruction.new('Quantity must be positive') if quantity.to_i.negative?

    quantity.to_i
  end

  def get_product_code(instruction_list)
    product_code = instruction_list[1]

    raise InvalidInstruction.new("Product code can't be blank") if product_code.nil?

    product_code
  end

  def show_store
    console_puts 'add <product_code> <quantity>'
    console_puts list_products(PRODUCTS)
  end

  def add_product(instruction_list)
    product_code = get_product_code(instruction_list)
    quantity = get_quantity(instruction_list)
    @cart.add_product(product_code, quantity)
    show_cart
  end

  def show_cart
    console_puts(@cart)
  end

  def list_products(products)
    header = '| Product Code | Name | Price |'
    [header, products].join("\n")
  end

  def console_puts(question)
    @output.puts '=============================='
    @output.puts question
    @output.puts '=============================='
  end

  def console_gets
    @input.gets&.chomp&.downcase&.split(' ')
  end
end
