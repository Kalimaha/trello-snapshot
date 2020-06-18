# frozen_string_literal: true

require 'rspec'
require 'trello/snapshot/repositories/cards_repository'

RSpec.describe Trello::Snapshot::Repositories::CardsRepository do
  describe '#cards' do
    subject(:cards) { described_class.cards }

    let(:response)          { double(Faraday::Response) }
    let(:id)                { '5ee9aacad92bb62c858374dd' }
    let(:date_last_update)  { '2020-06-17T05:57:37.459Z' }
    let(:list_id)           { '5ee9b0cf430af0725eacc7c1' }
    let(:name)              { 'Hallo, world!' }
    let(:expected_json) do
      [
        {
          "id": id,
          "closed": false,
          "dateLastActivity": date_last_update,
          "idList": list_id,
          "name": name,
          "labels": [
            {
              "id": '5ee99b68f1bb5752f6e0527d',
              "name": 'Spike'
            }
          ]
        }
      ]
    end

    before do
      allow(Faraday).to receive(:get).and_return(response)
      allow(response).to receive(:body).and_return(expected_json.to_json)
    end

    it 'fetches cards payload from Trello' do
      expect(cards.size).to eq(1)
    end

    it 'returns the ID of the card' do
      expect(cards.first.id).to eq(id)
    end

    it 'returns the status of the card' do
      expect(cards.first.closed?).to be_falsey
    end

    it 'returns the date of the last update of the card' do
      expect(cards.first.date_last_update.iso8601).to eq(Date.parse(date_last_update).iso8601)
    end

    it 'returns the ID of the list' do
      expect(cards.first.list_id).to eq(list_id)
    end

    it 'returns the name of the card' do
      expect(cards.first.name).to eq(name)
    end

    context 'but when there is a network error' do
      before do
        allow(Faraday).to receive(:get).and_raise(Faraday::Error.new('boom!'))
      end

      it 'returns an empty array' do
        expect(cards).to be_empty
      end
    end
  end

  describe '#url' do
    subject(:url) { described_class.url }

    before do
      allow(ENV).to receive(:[])
      allow(ENV).to receive(:[]).with('BOARD_ID').and_return('123')
      allow(ENV).to receive(:[]).with('TRELLO_KEY').and_return('456')
      allow(ENV).to receive(:[]).with('TRELLO_TOKEN').and_return('789')
    end

    it 'builds the correct URL for cards' do
      expect(url).to eq('https://api.trello.com/1/boards/123/cards?key=456&token=789')
    end
  end
end
