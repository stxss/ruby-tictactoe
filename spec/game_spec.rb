# frozen_string_literal: true
require_relative("../lib/player")
require_relative("../lib/game")

describe Game do
  describe "#play" do
    context "sets up game" do
      subject(:game) { described_class.new() }

      before do
        allow(game).to receive(:player_setup).once
        allow(game).to receive(:board_setup).once
      end

      it "sends player_setup" do
        expect(game).to receive(:player_setup)
        game.play
      end

      it "sends board_setup" do
        p1 = game.instance_variable_get(:@p1)
        p2 = game.instance_variable_get(:@p2)
        expect(game).to receive(:board_setup).with(p1, p2)
        game.play
      end
    end
  end
end
