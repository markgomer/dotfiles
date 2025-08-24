#!/bin/sh

# 1. Pick a random Pokémon name from the list provided by pokemon-colorscripts.
POKEMON_NAME=$(pokemon-colorscripts -l | shuf -n 1)

# 2. Export the name as an environment variable.
export ZELLIJ_POKEMON_NAME="$POKEMON_NAME"

# 3. Use 'exec' to start Zellij with the session named after the Pokémon.
exec zellij --session "$POKEMON_NAME"
