import 'package:advanced_icon/advanced_icon.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconly/iconly.dart';

enum PlayerState {
  stopped,
  playing,
  paused,
  completed,
  disposed,
}

class ViewSongPage extends StatefulWidget {
  const ViewSongPage({super.key});

  @override
  State<ViewSongPage> createState() => _ViewSongPageState();
}

class _ViewSongPageState extends State<ViewSongPage> {
  final _audioPlayer = AudioPlayer();

  bool _isPlaying = false;
  Duration _duration = Duration.zero;
  Duration _position = Duration.zero;

  @override
  void initState() {
    _setAudio();

    _audioPlayer.onPlayerStateChanged.listen((state) {
      setState(() {
        _isPlaying = state.toString() == PlayerState.playing.toString();
      });
    });

    _audioPlayer.onDurationChanged.listen((newDuration) {
      setState(() {
        _duration = newDuration;
      });
    });

    _audioPlayer.onPositionChanged.listen((newPosition) {
      setState(() {
        _position = newPosition;
      });
    });

    super.initState();
  }

  @override
  void setState(VoidCallback fn) {
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
    final smallTextStyle = Theme.of(context).textTheme.bodyMedium!;
    final largeTextStyle = Theme.of(context).textTheme.headlineMedium!;

    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Icon(Icons.more_vert),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset('assets/images/justine_bieber.jpeg'),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Yummy',
                  style: largeTextStyle.copyWith(fontWeight: FontWeight.bold),
                ),
                const AdvancedIcon(
                  icon: IconlyBold.heart,
                  size: 40,
                  color: Colors.red, //color will have no effect
                  gradient: LinearGradient(
                    //change gradient as per your requirement
                    colors: <Color>[Colors.pink, Colors.deepPurple],
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [0.2, 0.8],
                  ),
                ),
              ],
            ),
            Align(
                alignment: Alignment.centerLeft,
                child: Text('Justine Bieber', style: smallTextStyle)),
            const SizedBox(height: 40),
            Slider(
              onChanged: (value) async {
                final position = Duration(seconds: value.toInt());
                await _audioPlayer.seek(position);
              },
              activeColor: Colors.purple,
              min: 0,
              max: _duration.inSeconds.toDouble(),
              value: _position.inSeconds.toDouble(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_formatTime(_position)),
                  Text(_formatTime(_duration - _position)),
                ],
              ),
            ),
            const SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  iconSize: 30,
                  icon: const AdvancedIcon(
                    icon: Icons.shuffle,
                    gradient: LinearGradient(
                      //change gradient as per your requirement
                      colors: <Color>[Colors.pink, Colors.deepPurple],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.2, 0.8],
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  iconSize: 50,
                  icon: const AdvancedIcon(
                    icon: Icons.skip_previous,
                    gradient: LinearGradient(
                      //change gradient as per your requirement
                      colors: <Color>[Colors.pink, Colors.deepPurple],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.2, 0.8],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    if (_isPlaying) {
                      await _audioPlayer.pause();
                    } else {
                      await _audioPlayer.resume();
                    }
                  },
                  iconSize: 100,
                  icon: AdvancedIcon(
                    icon: _isPlaying ? Icons.pause_circle : IconlyBold.play,
                    gradient: const LinearGradient(
                      //change gradient as per your requirement
                      colors: <Color>[Colors.pink, Colors.deepPurple],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.2, 0.8],
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  iconSize: 50,
                  icon: const AdvancedIcon(
                    icon: Icons.skip_next,
                    gradient: LinearGradient(
                      //change gradient as per your requirement
                      colors: <Color>[Colors.pink, Colors.deepPurple],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.2, 0.8],
                    ),
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {},
                  iconSize: 30,
                  icon: const AdvancedIcon(
                    icon: Icons.repeat,
                    gradient: LinearGradient(
                      //change gradient as per your requirement
                      colors: <Color>[Colors.pink, Colors.deepPurple],
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [0.2, 0.8],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Future _setAudio() async {
    AudioCache.instance = AudioCache(prefix: 'assets/');
    final yummySong = AssetSource('audio/yummy.mp3');
    final sourceFuture = _audioPlayer.setSource(yummySong);
    final playFuture = _audioPlayer.play(yummySong);
    final releaseModeFuture = _audioPlayer.setReleaseMode(ReleaseMode.release);

    await Future.wait([sourceFuture, playFuture, releaseModeFuture]);
  }

  String _formatTime(Duration duration) {
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
