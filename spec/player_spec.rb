require_relative("../lib/player")

describe Player do
    describe "#ask_name" do
        context "asks player for name" do
            subject(:player) { described_class.new }

            before do
                order = "first"
                valid_name = "ruby"
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
                valid_char = "ruby"
                allow(player).to receive(:ask_char).with(order).and_return(valid_char)
            end

            it "stops loop and does not display error message regarding character" do
                error_message = "You can't use another player's character!"
                expect(player).not_to receive(:puts).with(error_message)
                player.create_player("first")
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

        context "verifies name if a name already exists" do
            subject(:player) { described_class.new }

            it "returns name if valid" do
                input = "ruby"
                order = "second"
                player.instance_variable_set(:@player1_name, "valid")
                verified = player.verify_name(order, input)
                expect(verified).to eq("ruby")
            end
        end

        context "verifies name if invalid" do
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

            xit "returns character if valid" do
            end
        end

        context "verifies char if a char already exists" do
            subject(:player) { described_class.new }

            xit "returns char if valid" do
            end
        end

        context "verifies character if invalid" do
            subject(:player) { described_class.new }

            xit "returns nil" do
            end
        end
    end
end
