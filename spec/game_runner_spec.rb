require 'spec_helper'

describe T3::GameRunner do
  it "initializes the console_io, configurations and game" do
    subject.console_io.should be_kind_of(T3::ConsoleIo)
    subject.configurations.should be_kind_of(T3::Configurations)
    subject.game.should be_kind_of(T3::Game)
  end

  context "#play_game" do
    it "plays a game once with the choice not to play again" do
      subject.configurations.should_receive(:configure_game)
      subject.game.should_receive(:start_game)
      subject.console_io.should_receive(:display_play_again_prompt)
      subject.console_io.should_receive(:get).and_return("n")
      subject.play_game
    end

    it "plays 3 games answering the play again message in different ways (uppercase and lowercase)" do
      subject.configurations.should_receive(:configure_game).exactly(3).times
      subject.game.should_receive(:start_game).exactly(3).times
      subject.console_io.should_receive(:display_play_again_prompt).exactly(3).times
      subject.console_io.should_receive(:get).and_return("y","Y","n")
      subject.play_game
    end

    it "plays 3 games answering the play again message in different ways, twice with invalid input" do
      subject.configurations.should_receive(:configure_game).exactly(3).times
      subject.game.should_receive(:start_game).exactly(3).times
      subject.console_io.should_receive(:display_invalid_selection).exactly(2).times
      subject.console_io.should_receive(:display_play_again_prompt).exactly(5).times
      subject.console_io.should_receive(:get).and_return("y","z","100","Y","n")
      subject.play_game
    end
  end
end
