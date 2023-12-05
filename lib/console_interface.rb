# frozen_string_literal: true
require_relative 'products/coffee_product'
require_relative 'products/green_tea_product'
require_relative 'products/strawberry_product'
require_relative 'command'
require_relative 'commands/add_item_command'
require_relative 'commands/list_store_command'
require_relative 'commands/show_checkout_command'
require_relative 'commands/quit_command'
require_relative 'cart'

INITIAL_PROMPT = 'Hello! Welcome to my store!'

class ConsoleInterface
  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
    @products = [
      GreenTeaProduct.new(
        code: 'GR1',
        name: 'Green Tea',
        price: 3.11
      ),
      StrawberryProduct.new(
        code: 'SR1',
        name: 'Strawberries',
        price: 5.00
      ),
      CoffeeProduct.new(
        code: 'CF1',
        name: 'Coffee',
        price: 11.23
      )
    ]
    @cart = Cart.new(available_products: @products)
    @instructions = [
      ListStoreCommand.new(
        keybind: 's',
        description: 'Show store items',
        products: @products,
        output: method(:console_puts)
      ),
      AddItemCommand.new(
        keybind: 'a',
        description: 'Add items to cart',
        cart: @cart,
        output: method(:console_puts)
      ),
      ShowCheckoutCommand.new(
        keybind: 'c',
        description: 'Show cart details',
        cart: @cart,
        output: method(:console_puts)
      ),
      QuitCommand.new(
        keybind: 'q',
        description: 'Quit store'
      )
    ]
  end

  def run
    console_puts list_instructions
    loop do
      instruction_list = console_gets
      command = get_command(instruction_list)
      instruction = @instructions.find { |e| e.keybind == command }

      raise CommandError, "Instruction '#{get_command(instruction_list)}' not recognized" if instruction.nil?

      instruction.perform(instruction_list)
    rescue CommandError, ProductNotFound => e
      console_puts "Invalid Instruction error: #{e.message}"
      console_puts list_instructions
    rescue Quit
      return
    end
  end

  def get_command(instruction_list)
    instruction_list.first
  end

  def list_instructions
    @instructions.join("\n")
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
