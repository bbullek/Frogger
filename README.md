# Frogger

DART: WHY FROGGER?
=======================================================================
Frogger is a classic 1981 arcade game where the end-all, be-all goal is
to spend a day in the life of a frog who only wants to cross the street
without being squished.

My Frogger project is a 2D game that runs in a simple game loop (in other
words, for every "update," the same stuff happens: Vehicles, logs, and
turtles move across the screen, Frogger (potentially) moves if the
player pressed an arrow key, Frogger is sent back to the beginning of 
the map if he collides with a "dangerous" object, etc.) In other words,
this game was simple to code and lends itself very well to an OOP language
like Dart -- classes include Scene, Frog, Car, FireEngine, Lilypad, and
so on. Significantly more complicated projects can be coded in Dart, but
I thought Frogger in particular was a fun prototype to demonstrate the
capabilities of Dart as a "web language" with a complete API for 
rendering images, playing sound, and handling user input.

Frogger is a straightforward game, but see the "HOW TO PLAY" section at
the end of this readme file for more detailed help.

INSTRUCTIONS/SET-UP
=======================================================================
Step 1: First, we'll need to download Dartium (a web browser capable of
        running web apps built with Dart, without the need for cross-
        compilation into JavaScript.)

        Download 64-bit Dartium for Linux from:
        https://storage.googleapis.com/dart-archive/channels/stable/release/1.20.1/dartium/dartium-linux-x64-release.zip
        OR feel free to select your own zip (e.g. for Mac OS) from:
        https://www.dartlang.org/install/archive

Step 2: Extract the zip into its own directory

Step 3: Add the Dartium executable to your path:
        export PATH=$PATH:/[ABSOLUTE PATH TO DARTIUM DIR]/chrome

Step 4: Navigate to the Frogger/web directory

Step 5: Enter the following: chrome Frogger.html

Step 6: Enjoy playing my mediocre Frogger clone :-)


HOW TO PLAY
=======================================================================
This game is played with the arrow keys. Pressing UP moves Frogger
forward, pressing LEFT moves him to the left, etc.

When the player launches the game, Frogger will be sitting at the
bottom of the game map. In front of him are rows of trucks, cars, and
fire engines, each moving at different speeds and in different directions.
Your first challenge is to get him across all five lanes of the street.

Next, Frogger will be facing the river, which is populated with slow 
turtles and a couple logs of varying lengths. As time passes, these objects
float along the river; Frogger can float with them if he hops onto them!

Leveraging the turtles and logs, and without touching the water (or else
he'll drown... because apparently frogs can't swim in this game), Frogger
needs to make his way across the river and jump onto a lilypad, where
he'll be safe.

Whenever Frogger reaches a lilypad, he'll hang out there while one of
Frogger's cousins spawn at the origin. He'll need to make the same 
journey until all five of the lilypads have a frog sitting on them, at 
which point, the player wins  the game (and can play again by pressing 
the space key).

If Frogger ever collides with a car, truck, or fire engine, he'll respawn
and need to try again.

Thank you for reading!
