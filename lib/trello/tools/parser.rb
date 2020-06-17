# frozen_string_literal: true

require 'date'
require 'trello/tools/action'

module Trello
  module Tools
    class Parser
      class << self
        def parse(payload)
          payload.map(&to_action)
        end

        private

        def to_action
          proc do |action|
            # byebug
            Action.new(
              type: action[:type],
              card_id: action[:data][:card][:id],
              date: Date.parse(action[:date]),
              old_list_id: action[:data][:old][:idList],
              list_id: action[:data][:list][:id]
            )
          end
        end
      end
    end
  end
end
