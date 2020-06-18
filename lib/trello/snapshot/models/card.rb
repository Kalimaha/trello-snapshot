# frozen_string_literal: true

module Trello
  module Snapshot
    module Models
      class Card
        attr_accessor :id, :closed, :date_last_update, :list_id, :name, :labels, :actions

        def initialize(id:, closed:, date_last_update:, list_id:, name:)
          @id = id
          @closed = closed
          @date_last_update = date_last_update
          @list_id = list_id
          @name = name
          @labels = []
          @actions = []
        end

        def closed?
          @closed == 'true'
        end
      end
    end
  end
end
