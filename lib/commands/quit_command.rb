# frozen_string_literal: true

require_relative '../command'

class Quit < StandardError
end

class QuitCommand < Command
  def perform(_)
    raise Quit, 'quit'
  end
end
