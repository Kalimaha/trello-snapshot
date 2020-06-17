# frozen_string_literal: true

require 'date'
require 'trello/snapshot/models/action'

module Trello
  module Snapshot
    class Parser
      class << self
        def parse(payload)
          payload.map(&to_action)
        end

        private

        def to_action
          proc do |action|
            Trello::Snapshot::Models::Action.new(
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
