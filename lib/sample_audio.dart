import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

enum PlayerState {
  /// initial state, stop has been called or an error occurred.
  stopped,

  /// Currently playing audio.
  playing,

  /// Pause has been called.
  paused,

  /// The audio successfully completed (reached the end).
  completed,

  /// The player has been disposed and should not be used anymore.
  disposed,
}

class SampleAudio extends StatefulWidget {
  const SampleAudio({super.key});

  @override
  State<SampleAudio> createState() => _SampleAudioState();
}

class _SampleAudioState extends State<SampleAudio> {
  final _audioPlayer = AudioPlayer();

  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    setAudio();

    //* Listen to states: playing, pause, stopped
    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state.toString() == PlayerState.playing.toString();
      });
    });

    //* Listen to audio duration
    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        _duration = newDuration;
      });
    });

    //* Listen to audio position
    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });
    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
    // Subscriptions only can be closed asynchronously,
    // therefore events can occur after widget has been disposed.
    if (mounted) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sample Audio'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Slider(
            onChanged: (value) async {
              final position = Duration(seconds: value.toInt());
              await _audioPlayer.seek(position);
            },
            min: 0,
            max: _duration.inSeconds.toDouble(),
            value: _position.inSeconds.toDouble(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(formatTime(_position)),
                Text(formatTime(_duration - _position)),
              ],
            ),
          ),
          CircleAvatar(
            radius: 35,
            child: IconButton(
              onPressed: () async {
                if (_isPlaying) {
                  await _audioPlayer.pause();
                } else {
                  await _audioPlayer.resume();
                }
              },
              icon: Icon(_isPlaying ? Icons.pause : Icons.play_arrow),
              iconSize: 50,
            ),
          )
        ],
      ),
    );
  }

  Future setAudio() async {
    AudioCache.instance = AudioCache(prefix: 'assets/');
    final yummySong = AssetSource('audio/yummy.mp3');

    //* So we can get the duration initially
    final sourceFuture = _audioPlayer.setSource(yummySong);

    //* Play audio from Assets
    final playFuture = _audioPlayer.play(yummySong);

    //* Release or Repeat or Stop the song when completed
    final releaseModeFuture = _audioPlayer.setReleaseMode(ReleaseMode.release);

    await Future.wait([sourceFuture, playFuture, releaseModeFuture]);
  }

  String formatTime(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final formattedTime = [
      if (duration.inHours > 0) hours,
      minutes,
      seconds,
    ].join(':');

    return formattedTime;
  }
}
