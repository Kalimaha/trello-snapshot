# frozen_string_literal: true

require 'rspec'
require 'trello/snapshot/services/build_snapshot'

RSpec.describe Trello::Snapshot::Services::BuildSnapshot do
  subject(:cards) { described_class.apply }

  let(:remote_card_1) { Trello::Snapshot::Models::Card.new(id: 1, closed: "false", date_last_update: Time.now, list_id: 2, name: "Hallo, world!") }
  let(:remote_cards) { [remote_card_1] }

  before do
    allow(Trello::Snapshot::Repositories::CardsRepository).to receive(:cards).and_return(remote_cards)
  end

  it "fetches the cards" do
    expect(cards.size).to eq(1)
  end
end
