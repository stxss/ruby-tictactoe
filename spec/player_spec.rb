# frozen_string_literal: true

require_relative '../lib/player'

describe Player do
  let(:new_player) { Player.new('stass', 'x', 0) }

  context 'when a new player is created correctly' do
    it 'has a correct name' do
      expect(new_player.name).to eq('stass')
    end

    it 'has a correct playing symbol' do
      expect(new_player.character).to eq('x')
    end

    it 'has a correct initial score (0)' do
      expect(new_player.score).to eq(0)
    end
  end
end


# TODO: when a player wins a round, update the score.
