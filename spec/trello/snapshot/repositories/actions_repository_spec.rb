# frozen_string_literal: true

require 'rspec'
require 'trello/snapshot/repositories/actions_repository'

RSpec.describe Trello::Snapshot::Repositories::ActionsRepository do
  let(:card_id) { 'T42' }

  describe '#actions' do
    subject(:actions)       { described_class.actions(card_id: card_id) }

    let(:response)          { double(Faraday::Response) }
    let(:id)                { '545a7acdd5b102337ef2bb59' }
    let(:old_list_id)       { '5457652102f27da5df36676b' }
    let(:old_list_name)     { 'Eggs' }
    let(:list_id)           { '54576523e9bef65eaaa16637' }
    let(:list_name)         { 'Spam' }
    let(:date_last_update)  { '2014-11-05T19:30:21.147Z' }
    let(:expected_json) do
      [
        {
          "id": id,
          "data": {
            "listAfter": {
              "name": list_name,
              "id": list_id
            },
            "listBefore": {
              "name": old_list_name,
              "id": old_list_id
            }
          },
          "date": date_last_update
        }
      ]
    end

    before do
      allow(Faraday).to receive(:get).and_return(response)
      allow(response).to receive(:body).and_return(expected_json.to_json)
    end

    it "parses Trello's JSON in an array of actions" do
      expect(actions.size).to eq(1)
    end

    it 'returns the action ID' do
      expect(actions.first.id).to eq(id)
    end

    it 'returns the action last update' do
      expect(actions.first.date_last_update.iso8601).to eq(Date.parse(date_last_update).iso8601)
    end

    it 'returns the action current list ID' do
      expect(actions.first.list_id).to eq(list_id)
    end

    it 'returns the action current list name' do
      expect(actions.first.list_name).to eq(list_name)
    end

    it 'returns the action old list ID' do
      expect(actions.first.old_list_id).to eq(old_list_id)
    end

    it 'returns the action old list name' do
      expect(actions.first.old_list_name).to eq(old_list_name)
    end

    context 'but when there is a network error' do
      before do
        allow(Faraday).to receive(:get).and_raise(Faraday::Error.new('boom!'))
      end

      it 'returns an empty array' do
        expect(actions).to be_empty
      end
    end
  end
  describe '#url' do
    subject(:url) { described_class.url(card_id: card_id) }

    before do
      allow(ENV).to receive(:[])
      allow(ENV).to receive(:[]).with('BOARD_ID').and_return('123')
      allow(ENV).to receive(:[]).with('TRELLO_KEY').and_return('456')
      allow(ENV).to receive(:[]).with('TRELLO_TOKEN').and_return('789')
    end

    it 'builds the correct URL for cards' do
      expect(url).to eq('https://api.trello.com/1/cards/T42/actions?key=456&token=789')
    end
  end
end
