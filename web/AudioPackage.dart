part of main;

// TODO: Credit http://www.classicgaming.cc/classics/frogger/sounds for files

/**
 * Holds the audio files for background music and assorted sound effects for
 * the game.
 */
class AudioPackage {
  /** The game's background music that plays on a loop. */
  AudioElement _bgMusic;

  /** The sound played when Frogger hops. */
  AudioElement _froggerHop;

  /** The sound made when Frogger jumps into the water. */
  AudioElement _froggerPlunk;

  /** The sound made when Frogger is squashed by a vehicle. */
  AudioElement _froggerSquashed;

  /** AudioPackage's constructor */
  AudioPackage() {
    _bgMusic = new AudioElement("sounds/bgMusic.wav")
      ..autoplay = true
      ..load();
    _froggerHop = new AudioElement("sounds/froggerHop.wav")
      ..autoplay = false
      ..load();
    _froggerPlunk = new AudioElement("sounds/froggerPlunk.wav")
      ..autoplay = false
      ..load();
    _froggerSquashed = new AudioElement("sounds/froggerSquashed.wav")
      ..autoplay = false
      ..load();
  }

  /* Getters and setters */
  AudioElement get froggerSquashed => _froggerSquashed;

  AudioElement get froggerPlunk => _froggerPlunk;

  AudioElement get froggerHop => _froggerHop;

  AudioElement get bgMusic => _bgMusic;
  /* End of getters and setters */
}