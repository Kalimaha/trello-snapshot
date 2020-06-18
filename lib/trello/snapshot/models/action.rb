# frozen_string_literal: true

module Trello
  module Snapshot
    module Models
      class Action
        attr_accessor :id, :date_last_update, :list_id, :list_name, :old_list_id, :old_list_name

        def initialize(id:, date_last_update:, list_id:, list_name:, old_list_id:, old_list_name:)
          @id = id
          @date_last_update = date_last_update
          @old_list_id = old_list_id
          @old_list_name = old_list_name
          @list_id = list_id
          @list_name = list_name
        end
      end
    end
  end
end
