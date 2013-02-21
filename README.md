TODO: display_win in console_io class needs to receive the player or player name, not the piece.  Which means game_win needs to return this information.

TODO: board_size in game class is messy

TODO:  winning gamepiece better (in game_rules), but not great

TODO:  does stuff in gamerunner need to be in game, since it's calling game a bunch

TODO:  I don't understand why I can't pull "PRIVATE" up higher in game_rules?

Ben:
-board construction is messy; help with re-factor
-regex being repeated; should it be a constant (in game_rules)
-game tests (where to start); and some methods are mocking themselves - not sure how to fix
-should I pass in board to just the two or three(?) methods in board rules or pass in the whole board