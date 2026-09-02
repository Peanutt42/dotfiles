#!/usr/bin/env bash

# Pauses all players if any is playing and only starts one player if no player is playing
#
# needed because a simple "playerctl --all-players play-pause" can play all players
# and a simple "playerctl play-pause" may only pause one player eventhough multiple are playing

if playerctl --all-players status 2>/dev/null | grep -q '^Playing$'; then
    playerctl --all-players pause
else
    playerctl play
fi
