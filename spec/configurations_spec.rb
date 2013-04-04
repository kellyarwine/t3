require 'spec_helper'

describe T3::Configurations do

  let(:board)                     { T3::Board.new(3)            }
  let(:game_rules)                { T3::GameRules.new(board)    }
  let(:validations)               { T3::Validations.new         }
  let(:player_1)                  { T3::Player::Human.new("x")  }
  let(:player_2)                  { T3::Player::EasyAi.new("o") }
  let(:players)                   { [player_1,player_2]         }
  let(:board_size)                { 3                           }
  let(:opponent)                  { "1"                         }
  let(:human_gamepiece)           { "x"                         }
  let(:ai_gamepiece)              { "o"                         }
  let(:turn_order)                { "1"                         }
  let(:subject)                   { T3::Configurations.new      }
  let(:configuration_selections)  { { :board_size => board_size, :opponent => opponent, :human_gamepiece => human_gamepiece, :ai_gamepiece => ai_gamepiece, :turn_order => turn_order } }

  it "configures the board, game rules, and players" do
    subject.configure_game(configuration_selections)
    subject.board.should be_kind_of(T3::Board)
    subject.board.size.should == 3
    subject.game_rules.should be_kind_of(T3::GameRules)
    subject.player_1.should be_kind_of(T3::Player::Human)
    subject.player_2.should be_kind_of(T3::Player::EasyAi)
    subject.players = players
    subject.setup_turn_order("1").should == [player_1,player_2]
  end

  context "#opponent" do
    it "should return a human opponent" do
      subject.opponent("3", "x", "o").should be_kind_of(T3::Player::Human)
    end

    it "should return an easy ai opponent" do
      subject.opponent("1", "x", "o").should be_kind_of(T3::Player::EasyAi)
    end

    it "should return a hard ai opponent" do
      subject.opponent("2", "x", "o").should be_kind_of(T3::Player::Minimax)
    end
  end

  context "#setup_turn_order" do
    it "returns an array of two players where player_1 is the first player and player_2 is the second player" do
      subject.players = players
      subject.setup_turn_order("1").should == [player_1,player_2]
    end

    it "returns an array of two players where player_2 is the first player and player_1 is the second player" do
      subject.players = players
      subject.setup_turn_order("2").should == [player_2,player_1]
    end
  end

end
