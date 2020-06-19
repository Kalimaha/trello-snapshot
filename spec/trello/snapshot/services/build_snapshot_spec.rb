# frozen_string_literal: true

require 'rspec'
require 'trello/snapshot/services/build_snapshot'

RSpec.describe Trello::Snapshot::Services::BuildSnapshot do
  subject(:cards) { described_class.apply }

  let(:action_1) do
    Trello::Snapshot::Models::Action.new(
      id: 2,
      date_last_update: Time.now,
      list_id: 3,
      list_name: 'Spam',
      old_list_id: 4,
      old_list_name: 'Eggs'
    )
  end
  let(:action_2) do
    Trello::Snapshot::Models::Action.new(
      id: 5,
      date_last_update: Time.now,
      list_id: 3,
      list_name: 'Spam',
      old_list_id: 4,
      old_list_name: 'Eggs'
    )
  end
  let(:actions)       { [action_1, action_2] }
  let(:remote_cards)  { [remote_card_1] }
  let(:remote_card_1) do
    Trello::Snapshot::Models::Card.new(
      id: 1,
      closed: 'false',
      date_last_update: Time.now,
      list_id: 2,
      name: 'Hallo, world!'
    )
  end

  before do
    allow(Trello::Snapshot::Repositories::Cards).to receive(:cards).and_return(remote_cards)
    allow(Trello::Snapshot::Repositories::Actions).to receive(:actions).with(card_id: 1).and_return(actions)
  end

  it 'fetches the cards' do
    expect(cards.size).to eq(1)
  end

  it 'adds the actions to the card' do
    expect(cards.first.actions.size).to eq(2)
  end
end
