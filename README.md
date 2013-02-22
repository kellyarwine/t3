TODO:  does stuff in gamerunner need to be in game, since it's calling game a bunch?

TODO:  if I replay the game, I can't be the same gamepiece as I was the first time; and now I'm getting a big infinite loop

TODO:  	need to allow player to pick names?
				need to allow player to pick computer's gamepiece?
				need to allow player to pick who goes first?

TODO:		winning gamepiece better (in game_rules), but not great
TODO:		re-factor winning gamepiece in game_rules class
TODO:		board_size in game class is messy

Ben:
-board construction is messy; help with re-factor
-regex being repeated; should it be a constant (in game_rules)
-game tests (where to start); and some methods are mocking themselves - not sure how to fix
-should I pass in board to just the two or three(? - there's quite a bit more then 2 or 3) methods in board rules or pass in the whole board
-available_spaces (in board) and spaces_open? (in game_rules) are very similar; can I have them work together?
-did something a bit crazy with display_and_get_move in both classes
-I don't understand why I can't pull "PRIVATE" up higher in game_rules?
- should setting up the turn order be part of setting up players or no?