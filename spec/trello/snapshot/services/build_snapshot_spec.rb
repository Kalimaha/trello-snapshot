# frozen_string_literal: true

require 'rspec'
require 'trello/snapshot/services/build_snapshot'

RSpec.describe Trello::Snapshot::Services::BuildSnapshot do
  subject(:cards) { described_class.apply }

  let(:action_1)      { build(:action) }
  let(:action_2)      { build(:action) }
  let(:actions)       { [action_1, action_2] }
  let(:remote_cards)  { [remote_card_1] }
  let(:remote_card_1) { build(:card) }

  before do
    allow(Trello::Snapshot::Repositories::Cards).to receive(:cards).and_return(remote_cards)
    allow(Trello::Snapshot::Repositories::Actions)
      .to receive(:actions).with(card_id: remote_card_1.id).and_return(actions)
  end

  it 'fetches the cards' do
    expect(cards.size).to eq(1)
  end

  it 'adds the actions to the card' do
    expect(cards.first.actions.size).to eq(2)
  end
end
