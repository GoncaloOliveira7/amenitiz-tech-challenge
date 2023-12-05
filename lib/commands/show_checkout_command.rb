# frozen_string_literal: true

require_relative '../command'

class ShowCheckoutCommand < Command
  def initialize(keybind:, description:, cart:, output:)
    @cart = cart
    @output = output
    super(keybind:, description:)
  end

  def perform(_)
    @output.call @cart
  end
end
