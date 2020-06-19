# frozen_string_literal: true

require 'envied'
require 'faraday'
require 'trello/snapshot/repositories/cards_repository'

module Trello
  module Snapshot
    module Services
      class BuildSnapshot
        class << self
          def apply
            Trello::Snapshot::Repositories::CardsRepository.cards
          end
        end
      end
    end
  end
end
