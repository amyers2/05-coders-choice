Name: Anthony Myers           ID: 46989531

## Proposed Project

I plan to create a simple blackjack game that has the capability of 
simulating 1M or so parallel hands of blackjack to determine the best
strategy in terms of when to "hit" and when to "stand", based on the
fact that the dealer must "hit" until they reach at least 17. I would
like to see the odds of winning between a player stopping at 17, 18, 
19, and 20 point values. I also would like a second mode where a human
player can play against a computer "dealer". No betting involved, just
a win/lose count.

## Outline Structure

**#1:** A deck module that handles the obtaining of a new deck, shuffling, etc.
**#2**: A supervised OTP game server for carrying out the actions of the game.
**#3**: A module for simulating and spawning the various concurrent blackjack 
hands for statistical calculations.
**#4**: A human player interface for playing against the computer "dealer".

Once I get into it, I may change around the structure a bit, but this is
my initial idea.