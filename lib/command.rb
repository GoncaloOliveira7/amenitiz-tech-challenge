class CommandError < StandardError
end

class Command
  attr_reader :keybind

  def initialize(keybind:, description:)
    @keybind = keybind
    @description = description
  end

  def perform(*_)
    nil
  end

  def get_quantity(instruction_list)
    quantity = instruction_list[2]

    raise CommandError, "Quantity can't be blank" if quantity.nil?

    raise CommandError, 'Quantity must be positive' unless quantity.to_i.positive?

    quantity.to_i
  end

  def get_product_code(instruction_list)
    product_code = instruction_list[1]

    raise CommandError, "Product code can't be blank" if product_code.nil?

    product_code
  end

  def to_s
    "#{@keybind}) #{@description}"
  end
end
