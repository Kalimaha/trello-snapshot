# frozen_string_literal: true

require 'factory_bot'
require 'securerandom'

FactoryBot.define do
  factory :action, class: Trello::Snapshot::Models::Action do
    initialize_with do
      new(
        id: SecureRandom.uuid,
        date_last_update: Time.now,
        list_id: SecureRandom.uuid,
        list_name: 'Current List',
        old_list_id: SecureRandom.uuid,
        old_list_name: 'Old List'
      )
    end
  end

  factory :card, class: Trello::Snapshot::Models::Card do
    initialize_with do
      new(
        id: SecureRandom.uuid,
        closed: 'false',
        date_last_update: Time.now,
        list_id: SecureRandom.uuid,
        name: 'Do this hey'
      )
    end
  end
end
