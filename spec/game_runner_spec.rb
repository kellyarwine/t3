require 'spec_helper'

describe GameRunner do
	let(:game) { double('Game') }
	let(:console_io) { double('ConsoleIo') }

	it "displays a play again message" do
			console_io.should_receive(:display_play_again)
			game.should_receive(:new)
			subject.play_game
	end

	context "#display_and_get_play_again" do
		it "displays a play again message" do
				console_io.should_receive(:display_play_again).and_return("Y")
				subject.should_receive(:play_game)
				subject.play_game
		end
	end
end