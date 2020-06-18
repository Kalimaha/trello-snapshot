# frozen_string_literal: true

require 'envied'
require 'faraday'
require 'trello/snapshot/models/action'

module Trello
  module Snapshot
    module Repositories
      class ActionsRepository
        TRELLO_BASE_URL = 'https://api.trello.com'

        class << self
          def actions(card_id:)
            JSON.parse(Faraday.get(url(card_id: card_id)).body).map(&to_action)
          rescue Faraday::Error
            []
          end

          def url(card_id:)
            ENVied.require

            "#{TRELLO_BASE_URL}/1/cards/#{card_id}/actions?key=#{ENVied.TRELLO_KEY}&token=#{ENVied.TRELLO_TOKEN}"
          end

          private

          # rubocop:disable Metrics/AbcSize
          def to_action
            proc do |action|
              Trello::Snapshot::Models::Action.new(
                id: action['id'],
                date_last_update: Date.parse(action['date']),
                old_list_id: action['data']['listBefore']['id'],
                old_list_name: action['data']['listBefore']['name'],
                list_id: action['data']['listAfter']['id'],
                list_name: action['data']['listAfter']['name']
              )
            end
          end
          # rubocop:enable Metrics/AbcSize
        end
      end
    end
  end
end
