PRODUCTS = [
  { code: 'GR1', name: 'Green Tea', price: 3.11 },
  { code: 'SR1', name: 'Strawberries', price: 5.00 },
  { code: 'CF1', name: 'Coffee', price: 11.23 }
]

INITIAL_PROMPT = "Hello! Welcome to my store!

Options:
  s) store
  c) cart
  q) quit
"

class ConsoleInterface
  def initialize(input: $stdin, output: $stdout)
    @input = input
    @output = output
    @shooping_cart = []
  end

  def run
    console_puts INITIAL_PROMPT
    loop do
      instruction_list = console_gets

      case get_command(instruction_list)
      when 's'
        console_puts 'add <product_code> <quantity>'
        console_puts list_products(PRODUCTS)
      when 'add'
        product_code = instruction_list[1]
        quantity = instruction_list[2].to_i
        add_product(product_code, quantity)
        show_cart
      when 'c'
        show_cart
      when 'q'
        return
      else
        console_puts "Instruction #{instruction_list} not recognized"
        console_puts INITIAL_PROMPT
      end
    end
  end

  def get_command(instruction_list)
    instruction_list.first
  end

  def add_product(product_code, quantity)
    product = PRODUCTS.find { |e| e[:code].downcase == product_code }
    checkout_item = @shooping_cart.find { |e| e[:code].downcase == product_code }
    if checkout_item
      checkout_item[:quantity] += quantity
    else
      @shooping_cart.append({
                              code: product[:code],
                              quantity:,
                              price_per_unit: product[:price]
                            })
    end
  end

  def list_products(products)
    header = '| Product Code | Name | Price |'
    produtct_items = products.map { |e| "| #{e[:code]} | #{e[:name]} | #{e[:price]} € |" }
    [header, produtct_items].join("\n")
  end

  def show_cart
    sum = @shooping_cart.sum do |shooping_item|
      calculate_item_price(shooping_item)
    end
    console_puts sum
  end

  def calculate_item_price(shooping_item)
    original_price = shooping_item[:price_per_unit] * shooping_item[:quantity]
    discount_value = apply_strawberry_discout(shooping_item) + apply_green_tea_discout(shooping_item) + apply_coffee_discout(shooping_item)

    (original_price - discount_value).round(2)
  end

  def apply_green_tea_discout(shooping_item)
    return 0.0 if shooping_item[:code] != 'GR1' || shooping_item[:quantity] < 2

    discount = (shooping_item[:quantity] / 2).to_i * shooping_item[:price_per_unit]
    (shooping_item[:price_per_unit] * shooping_item[:quantity] - discount).round(2)
  end

  def apply_strawberry_discout(shooping_item)
    return 0.0 if shooping_item[:code] != 'SR1' || shooping_item[:quantity] < 3

    discount = 0.1
    (shooping_item[:price_per_unit] * shooping_item[:quantity] * discount).round(2)
  end

  def apply_coffee_discout(shooping_item)
    return 0.0 if shooping_item[:code] != 'CF1' || shooping_item[:quantity] < 3

    discount = 1.0 / 3.0
    (shooping_item[:price_per_unit] * shooping_item[:quantity] * discount).round(2)
  end

  def line_break
    @output.puts '=============================='
  end

  def console_puts(question)
    line_break
    @output.puts question
    line_break
  end

  def console_gets
    @input.gets&.chomp&.downcase&.split(' ')
  end
end
