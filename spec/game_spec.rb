# frozen_string_literal: true

require_relative('../lib/game')
require_relative('../lib/player')

describe Game do
  context 'when creating a new game' do
    subject(:new_game) { described_class.new }

    describe '#play' do
      it 'creates two players, with different names and playing symbols and sets up the board' do
        allow(new_game).to receive(:player_setup)
        allow(new_game).to receive(:board_setup)
        new_game.play
      end
    end

    describe '#player_setup' do
      let(:player1) { instance_double(Player) }

      before do
        name1 = "stass"
        allow(player1).to receive(:gets)
        allow(player1).to receive(:create_player).and_return(name1)
      end

      it 'creates player1' do
        expect(player1).to receive(:create_player).with("first")
        new_game.player_setup
      end
    end
  end
end
