import 'package:audio_player_service/audio_player_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:just_audio/just_audio.dart';
import 'package:mocktail/mocktail.dart';

class _MockAudioPlayer extends Mock implements AudioPlayer {}

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late _MockAudioPlayer mockAudioPlayer;
  late AudioPlayerService sut;

  setUp(() {
    mockAudioPlayer = _MockAudioPlayer();
    sut = AudioPlayerService(audioPlayer: mockAudioPlayer);
  });

  tearDown(() {
    sut.dispose();
  });

  void arrangeLoadResponse(String path) {
    when(
      () => mockAudioPlayer.setFilePath(path),
    ).thenAnswer((_) async => null);
  }

  void arrangePlayResponse() {
    when(
      mockAudioPlayer.play,
    ).thenAnswer((_) async {});
  }

  void arrangePauseResponse() {
    when(
      mockAudioPlayer.pause,
    ).thenAnswer((_) async {});
  }

  void arrangeStopResponse() {
    when(
      mockAudioPlayer.stop,
    ).thenAnswer((_) async {});
  }

  void arrangeSeekResponse(Duration position) {
    when(
      () => mockAudioPlayer.seek(position),
    ).thenAnswer((_) async {});
  }

  void arrangeSetSpeedResponse(double speed) {
    when(
      () => mockAudioPlayer.setSpeed(speed),
    ).thenAnswer((_) async {});
  }

  void arrangeSetVolumeResponse(double volume) {
    when(
      () => mockAudioPlayer.setVolume(volume),
    ).thenAnswer((_) async {});
  }

  void arrangeDisposeResponse() {
    when(
      mockAudioPlayer.dispose,
    ).thenAnswer((_) async {});
  }

  group('AudioPlayerService', () {
    test('can be instantiated', () {
      expect(AudioPlayerService(), isNotNull);
    });

    test('can load audio file', () {
      const path = 'test/assets/audio.mp3';
      arrangeLoadResponse(path);
      sut.load(path);

      verify(() => mockAudioPlayer.setFilePath(path)).called(1);
    });

    test('can throw LoadAudioException when could not load audio file', () {
      const path = 'test/assets/audio.mp3';

      expect(() => sut.load(path), throwsA(isA<LoadAudioException>()));
    });

    test('can play audio', () {
      arrangePlayResponse();
      sut.play();

      verify(mockAudioPlayer.play).called(1);
    });

    test('can throw PlayAudioException when could not play the audio', () {
      expect(() => sut.play(), throwsA(isA<PlayAudioException>()));
    });

    test('can pause audio', () {
      arrangePauseResponse();
      sut.pause();

      verify(mockAudioPlayer.pause).called(1);
    });

    test('can throw PauseAudioException when could not pause the audio', () {
      expect(() => sut.pause(), throwsA(isA<PauseAudioException>()));
    });

    test('can stop audio', () {
      arrangeStopResponse();
      sut.stop();

      verify(mockAudioPlayer.stop).called(1);
    });

    test('can throw StopAudioException when could not stop the audio', () {
      expect(() => sut.stop(), throwsA(isA<StopAudioException>()));
    });

    test('can seek to different audio position', () {
      arrangeSeekResponse(Duration.zero);
      sut.seek(Duration.zero);

      verify(() => mockAudioPlayer.seek(Duration.zero)).called(1);
    });

    test(
        'can throw SeekAudioPositionException when could not seek to the '
        'different audio position', () {
      expect(
        () => sut.seek(Duration.zero),
        throwsA(isA<SeekAudioPositionException>()),
      );
    });

    test('can set the speed of the audio', () {
      arrangeSetSpeedResponse(1);
      sut.setSpeed(1);

      verify(() => mockAudioPlayer.setSpeed(1)).called(1);
    });

    test(
        'can throw SetAudioPlaybackSpeedException when could not set the speed '
        'of the audio', () {
      expect(
        () => sut.setSpeed(1),
        throwsA(isA<SetAudioPlaybackSpeedException>()),
      );
    });

    test('can set the volume of the audio', () {
      arrangeSetVolumeResponse(1);
      sut.setVolume(1);

      verify(() => mockAudioPlayer.setVolume(1)).called(1);
    });

    test(
        'can throw SetAudioVolumeException when could not set the volume of '
        'the audio', () {
      expect(() => sut.setVolume(1), throwsA(isA<SetAudioVolumeException>()));
    });

    test('can dispose the audio player', () {
      arrangeDisposeResponse();
      sut.dispose();

      verify(mockAudioPlayer.dispose).called(1);
    });
  });
}
