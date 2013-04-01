require 'spec_helper'

describe T3::GameRunner do

    let(:io)      { T3::Io.new         }
    let(:subject) { T3::GameRunner.new }

  it "initializes the io, configurations and game" do
    subject.io.should be_kind_of(T3::Io)
    subject.prompter.should be_kind_of(T3::Prompter)
    subject.configurations.should be_kind_of(T3::Configurations)
    subject.game.should be_kind_of(T3::Game)
  end

  context "#play_game" do
    it "plays a game once with the choice not to play again" do
      subject.configurations.should_receive(:configure_game)
      subject.game.should_receive(:start_game)
      subject.io.should_receive(:display_play_again_prompt)
      subject.io.should_receive(:get).and_return("n")
      subject.play_game
    end

    it "plays 3 games answering the play again message in different ways (uppercase and lowercase)" do
      subject.configurations.should_receive(:configure_game).exactly(3).times
      subject.game.should_receive(:start_game).exactly(3).times
      subject.io.should_receive(:display_play_again_prompt).exactly(3).times
      subject.io.should_receive(:get).and_return("y","Y","n")
      subject.play_game
    end

    it "plays 3 games answering the play again message in different ways, twice with invalid input" do
      subject.configurations.should_receive(:configure_game).exactly(3).times
      subject.game.should_receive(:start_game).exactly(3).times
      subject.io.should_receive(:display_invalid_selection).exactly(2).times
      subject.io.should_receive(:display_play_again_prompt).exactly(5).times
      subject.io.should_receive(:get).and_return("y","z","100","Y","n")
      subject.play_game
    end
  end
end
