TODO: display_win in console_io class needs to receive the player or player name, not the piece.  Which means game_win needs to return this information.

TODO: board_size in game class is messy

TODO:  winning gamepiece better (in game_rules), but not great

TODO:  does stuff in gamerunner need to be in game, since it's calling game a bunch

TODO:  I don't understand why I can't pull "PRIVATE" up higher in game_rules?

TODO: re-factor winning gamepiece in game_rules class

TODO:  re-factor winning gamepiece line in game loop too

TODO:  human can be a capital x and that shouldn't be allowed; really, the computer's gamepiece is not being stored, so human can be an x and so can computer.  blah.

TODO:  if I replay the game, I can't be the same gamepiece as I was the first time

Ben:
-board construction is messy; help with re-factor
-regex being repeated; should it be a constant (in game_rules)
-game tests (where to start); and some methods are mocking themselves - not sure how to fix
-should I pass in board to just the two or three(?) methods in board rules or pass in the whole board
-available_spaces (in board) and spaces_open? (in game_rules) are very similar; can I have them work together?
-did something a bit crazy with display_and_get_move in both classes