require_relative("../lib/player")

describe Player do
  describe "#ask_name" do
    context "asks player for name" do
      subject(:player) { described_class.new }

      before do
        order = "first"
        valid_name = "name"
        allow(player).to receive(:ask_name).with(order).and_return(valid_name)
      end

      it "stops loop and does not display error message regarding name" do
        error_message = "You can't use another player's name!"
        expect(player).not_to receive(:puts).with(error_message)
        player.ask_name("first")
      end
    end
  end

  describe "#ask_char" do
    context "asks player for character" do
      subject(:player) { described_class.new }

      before do
        order = "first"
        valid_char = "x"
        allow(player).to receive(:ask_char).with(order).and_return(valid_char)
      end

      it "then stops loop and does not display error message regarding character" do
        error_message = "You can't use another player's character!"
        expect(player).not_to receive(:puts).with(error_message)
        player.ask_char("first")
      end
    end
  end

  describe "#verify_name" do
    context "verifies name" do
      subject(:player) { described_class.new }

      it "returns name if valid" do
        input = "valid"
        order = "first"
        verified = player.verify_name(order, input)
        expect(verified).to eq("valid")
      end
    end

    context "if a name already exists" do
      subject(:player) { described_class.new }

      it "returns name if valid" do
        input = "ruby"
        order = "second"
        player.instance_variable_set(:@player1_name, "valid")
        verified = player.verify_name(order, input)
        expect(verified).to eq("ruby")
      end
    end

    context "if invalid" do
      subject(:player) { described_class.new }

      it "returns nil" do
        input = "valid"
        order = "second"
        player.instance_variable_set(:@player1_name, "valid")
        verified = player.verify_name(order, input)
        expect(verified).to be_nil
      end
    end
  end

  describe "#verify_char" do
    context "verifies character" do
      subject(:player) { described_class.new }

      it "returns character if valid" do
        input = "x"
        order = "first"
        verified = player.verify_name(order, input)
        expect(verified).to eq("x")
      end
    end

    context "if a char already exists" do
      subject(:player) { described_class.new }

      it "returns char if valid" do
        input = "o"
        order = "second"
        player.instance_variable_set(:@player1_character, "x")
        verified = player.verify_name(order, input)
        expect(verified).to eq("o")
      end

      it "returns nil if char is equal to the other player's char" do
        input = "x"
        order = "second"
        player.instance_variable_set(:@player1_character, "x")
        verified = player.verify_char(order, input)
        expect(verified).to be_nil
      end
    end

    context "if invalid" do
      subject(:player) { described_class.new }

      it "returns nil" do
        input = "4"
        order = "first"
        verified = player.verify_char(order, input)
        expect(verified).to be_nil
      end
    end
  end
end
