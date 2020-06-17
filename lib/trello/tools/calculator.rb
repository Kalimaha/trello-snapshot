# frozen_string_literal: true

module Trello
  module Tools
    class Calculator
      class << self
        def sum(alpha, beta)
          alpha + beta
        end

        def divide(alpha, beta)
          raise StandardError, 'Division by zero.' if beta.zero?

          1.0 * alpha / beta
        end
      end
    end
  end
end
