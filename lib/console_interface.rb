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
        console_puts @shooping_cart
      when 'c'
        console_puts @shooping_cart
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
        quantity: quantity,
        price_per_unit: product[:price]
      })
    end
  end

  def list_products(products)
    header = "| Product Code | Name | Price |"
    produtct_items = products.map { |e| "| #{e[:code]} | #{e[:name]} | #{e[:price]} € |" }
    [header, produtct_items].join("\n")
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
