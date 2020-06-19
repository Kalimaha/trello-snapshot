# frozen_string_literal: true

require 'envied'
require 'faraday'
require 'trello/snapshot/repositories/cards'

module Trello
  module Snapshot
    module Services
      class BuildSnapshot
        class << self
          def apply
            cards.each(&fetch_and_store_actions)
          end

          private

          def cards
            Trello::Snapshot::Repositories::Cards.cards
          end

          def fetch_and_store_actions
            proc do |card|
              card.actions = Trello::Snapshot::Repositories::Actions.actions(card_id: card.id)
            end
          end
        end
      end
    end
  end
end
