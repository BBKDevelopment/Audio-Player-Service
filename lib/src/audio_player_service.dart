import 'dart:developer';

import 'package:just_audio/just_audio.dart';

/// An exception thrown when audio player fails to load the audio.
class LoadAudioException implements Exception {}

/// An exception thrown when audio player fails to play the audio.
class PlayAudioException implements Exception {}

/// An exception thrown when audio player fails to pause the audio.
class PauseAudioException implements Exception {}

/// An exception thrown when audio player fails to stop the audio.
class StopAudioException implements Exception {}

/// An exception thrown when audio player fails to set playback speed.
class SetAudioPlaybackSpeedException implements Exception {}

/// An exception thrown when audio player fails to seek to the position.
class SeekAudioPositionException implements Exception {}

/// An exception thrown when audio player fails to set the volume.
class SetAudioVolumeException implements Exception {}

/// An exception thrown when audio player fails to add or remove the listener.
class AudioListenerException implements Exception {}

/// {@template audio_player_service}
/// A service that handles audio playback.
///
/// This service uses the `just_audio` package to play audio.
///
/// ```dart
/// final audioPlayerService = AudioPlayerService(
///  audioPlayer: AudioPlayer(),
/// );
/// ```
/// {@endtemplate}
class AudioPlayerService {
  /// {@macro audio_player_service}
  AudioPlayerService({
    AudioPlayer? audioPlayer,
  }) : _audioPlayer = audioPlayer ?? AudioPlayer();

  final AudioPlayer _audioPlayer;

  /// Loads an audio file from a [filePath].
  ///
  /// Throws a [LoadAudioException] if the audio fails to load.
  Future<void> load(String filePath) async {
    try {
      await _audioPlayer.setFilePath(filePath);
    } catch (_) {
      log('Failed to load audio file: $filePath', name: 'AudioPlayerService');
      throw LoadAudioException();
    }
  }

  /// Plays the currently loaded audio.
  ///
  /// Throws a [PlayAudioException] if the audio fails to play.
  Future<void> play() async {
    try {
      await _audioPlayer.play();
    } catch (_) {
      log('Failed to play audio!', name: 'AudioPlayerService');
      throw PlayAudioException();
    }
  }

  /// Pauses the currently playing audio.
  ///
  /// Throws a [PauseAudioException] if the audio fails to pause.
  Future<void> pause() async {
    try {
      await _audioPlayer.pause();
    } catch (_) {
      log('Failed to pause audio!', name: 'AudioPlayerService');
      throw PauseAudioException();
    }
  }

  /// Stops the currently playing audio.
  ///
  /// Throws a [StopAudioException] if the audio fails to stop.
  Future<void> stop() async {
    try {
      await _audioPlayer.stop();
    } catch (_) {
      log('Failed to stop audio!', name: 'AudioPlayerService');
      throw StopAudioException();
    }
  }

  /// Sets the playback speed of the currently playing audio.
  ///
  /// Throws a [SeekAudioPositionException] if the audio fails to seek.
  Future<void> seek(Duration position) async {
    try {
      await _audioPlayer.seek(position);
    } catch (_) {
      log('Failed to seek audio!', name: 'AudioPlayerService');
      throw SeekAudioPositionException();
    }
  }

  /// Sets the playback speed of the currently playing audio.
  ///
  /// Throws a [SetAudioPlaybackSpeedException] if the audio fails to set
  /// playback speed.
  Future<void> setSpeed(double speed) async {
    try {
      await _audioPlayer.setSpeed(speed);
    } catch (_) {
      log('Failed to set playback speed!', name: 'AudioPlayerService');
      throw SetAudioPlaybackSpeedException();
    }
  }

  /// Sets the volume of the currently playing audio.
  ///
  /// Throws a [SetAudioVolumeException] if the audio fails to set volume.
  Future<void> setVolume(double volume) async {
    try {
      await _audioPlayer.setVolume(volume);
    } catch (_) {
      log('Failed to set volume!', name: 'AudioPlayerService');
      throw SetAudioVolumeException();
    }
  }

  /// Disposes the audio player.
  Future<void> dispose() async {
    try {
      await _audioPlayer.dispose();
    } catch (_) {
      log('Failed to dispose audio player!', name: 'AudioPlayerService');
    }
  }
}
