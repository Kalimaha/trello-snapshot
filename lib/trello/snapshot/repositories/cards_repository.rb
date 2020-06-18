# frozen_string_literal: true

require 'envied'
require 'faraday'
require 'trello/snapshot/models/card'

module Trello
  module Snapshot
    module Repositories
      class CardsRepository
        TRELLO_BASE_URL = 'https://api.trello.com'

        class << self
          def cards
            JSON.parse(Faraday.get(url).body).map { |x| to_card(x) }
          rescue Faraday::Error
            []
          end

          def url
            ENVied.require

            "#{TRELLO_BASE_URL}/1/boards/#{ENVied.BOARD_ID}/cards?key=#{ENVied.TRELLO_KEY}&token=#{ENVied.TRELLO_TOKEN}"
          end

          private

          def to_card(card)
            Trello::Snapshot::Models::Card.new(
              id: card['id'],
              closed: card['closed'],
              date_last_update: Date.parse(card['dateLastActivity']),
              list_id: card['idList'],
              name: card['name']
            )
          end
        end
      end
    end
  end
end
