require 'spec_helper'

describe Configurations do

	context "#invalid_gamepiece?" do
		it "returns true when gamepiece is one character and not a duplicate" do
			subject.gamepieces = ["o"]
			subject.invalid_gamepiece?("a").should be_false
		end

		it "returns false when gamepiece is two characters and not a duplicate" do
			subject.gamepieces = ["o"]
			subject.invalid_gamepiece?("aa").should be_true
		end

		it "returns false when gamepiece is one characters and a duplicate" do
			subject.gamepieces = ["a"]
			subject.invalid_gamepiece?("a").should be_true
		end
	end

	context "#one_character?" do
		it "returns true when gamepiece is one character" do
			subject.one_character?("a").should be_true
		end

		it "returns false when gamepiece is more than one character" do
			subject.one_character?("ab").should be_false
		end

		it "returns false when gamepiece is more than one character" do
			subject.one_character?("ppp").should be_false
		end	
	end

	context "#duplicate_gamepiece?" do
		it "returns true when the gamepiece is a duplicate" do
			subject.gamepieces = ["x"]
			subject.duplicate_gamepiece?("y").should be_false
		end

		it "returns true when the gamepiece is a duplicate" do
			subject.gamepieces = ["y"]
			subject.duplicate_gamepiece?("y").should be_true
		end
	end

	it "returns true when board is invalid" do
	subject.invalid_board_size?(4).should be_true
	end

end