# frozen_string_literal: true

module Trello
  module Snapshot
    module Models
      class Action
        attr_accessor :type, :card_id, :date, :old_list_id, :list_id

        def initialize(type:, card_id:, date:, old_list_id:, list_id:)
          @type = type
          @card_id = card_id
          @date = date
          @old_list_id = old_list_id
          @list_id = list_id
        end
      end
    end
  end
end
