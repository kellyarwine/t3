TODO:
-I don't like that is says "Who goes first human or human?"
-Can't be the same gamepiece as from the previous game.
-If you're playing human vs. human, the question to ask who is which gamepiece doesn't change.
-add code to announce whether "Computer" or "Human" wins.  Right now, it's just gamepiece.

-decouple io/rename it

-re-factor winning gamepiece in game_rules class
-refactor board construction

-available_spaces (in board) and spaces_open? (in game_rules) are very similar; can I have them work together? shoulld be in board
-add strategy pattern
-turn instances into mocks
-add rake tasks
-seperate unit tests and integration tests
