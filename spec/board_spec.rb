require_relative("../lib/board")

describe Board do
  describe "#row_win?" do
    let(:player1) { double("player1") }
    let(:player2) { double("player2") }
    subject(:round) { described_class.new(player1, player2) }

    context "when a user has a winning sequence - row" do
        it "returns true" do
            board = [["x", "x", "x"], [4, 5, 6], [7, 8, 9]]
            round.instance_variable_set(:@board, board)
            round.instance_variable_set(:@marker, "x")
            expect(round).to be_row_win
        end
    end

    context "when a user has a winning sequence - column" do
        it "returns true" do
            board = [["x", 2, 3], ["x", 5, 6], ["x", 8, 9]]
            round.instance_variable_set(:@board, board)
            round.instance_variable_set(:@marker, "x")
            expect(round).to be_col_win
        end
    end

    context "when a user has a winning sequence - diagonal" do
        it "returns true" do
            board = [["x", 2, 3], [4, "x", 6], [7, 8, "x"]]
            round.instance_variable_set(:@board, board)
            round.instance_variable_set(:@marker, "x")
            expect(round).to be_diag_win
        end
    end
  end
end
