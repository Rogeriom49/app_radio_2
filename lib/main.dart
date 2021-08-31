import 'dart:math';

import 'package:audio_session/audio_session.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:audio_service/audio_service.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:flutter_radio_6/common.dart';

// void main() => runApp(MyApp());

Future<void> main() async {
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: false,
  );
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  static int _nextMediaId = 0;
  late AudioPlayer _player;
  final _playlist = ConcatenatingAudioSource(children: [
    // ClippingAudioSource(
    //   start: Duration(seconds: 60),
    //   end: Duration(seconds: 90),
    //   child: 
    //   AudioSource.uri(
    //     Uri.parse(
    //       "http://audio8.cmaudioevideo.com:8193/stream")),
    //   tag: AudioMetadata(
    //     album: "Rede Nossa Rádio",
    //     title: "Mundo Agro",
    //     artwork:
    //         "https://i.imgur.com/r9SNHJr.png",
    //     wpp: "",     
    //   ),
    // ),
    AudioSource.uri(
      Uri.parse(
          "http://audio8.cmaudioevideo.com:8247/stream"),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Rede Nossa Rádio",
        title: "Entre-Ijuis 90.7",
        artUri: Uri.parse("https://i.imgur.com/ZhfmMet.png"),
      ),
    ),
    AudioSource.uri(
      Uri.parse("http://audio8.cmaudioevideo.com:8241/stream"),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Rede Nossa Rádio",
        title: "Horizontina 95.7",
        artUri: Uri.parse("https://i.imgur.com/rnZlCOG.png"),
      ),
    ),
    AudioSource.uri(
      Uri.parse("http://audio8.cmaudioevideo.com:8187/stream"),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Rede Nossa Rádio",
        title: "Caibi 96.7",
        artUri: Uri.parse("https://i.imgur.com/GvQc49b.png"),
      ),
    ),
        AudioSource.uri(
      Uri.parse("http://audio8.cmaudioevideo.com:8207/stream"),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Rede Nossa Rádio",
        title: "Passos Maia 100.7",
        artUri: Uri.parse("https://i.imgur.com/Ac2MCF6.png"),
      ),
    ),
        AudioSource.uri(
      Uri.parse("http://audio8.cmaudioevideo.com:8092/stream"),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Rede Nossa Rádio",
        title: "Palmitos 101.5",
        artUri: Uri.parse("https://i.imgur.com/33QlUsU.png"),
      ),
    ),
        AudioSource.uri(
      Uri.parse("http://audio8.cmaudioevideo.com:8141/stream"),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Rede Nossa Rádio",
        title: "São Carlos 104.1",
        artUri: Uri.parse("https://i.imgur.com/DzrTwiY.png"),
      ),
    ),
        AudioSource.uri(
      Uri.parse("http://audio8.cmaudioevideo.com:8181/stream"),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Rede Nossa Rádio",
        title: "Irineópolis 105.9",
        artUri: Uri.parse("https://i.imgur.com/BdZpDhU.png"),
      ),
    ),
        AudioSource.uri(
      Uri.parse(
          "http://audio8.cmaudioevideo.com:8193/stream"),
      tag: MediaItem(
        id: '${_nextMediaId++}',
        album: "Rede Nossa Rádio",
        title: "Mundo Agro",
        artUri: Uri.parse("https://i.imgur.com/r9SNHJr.png"),
      ),
    ),

  ]);
  int _addedCount = 0;

  @override
  void initState() {
    super.initState();
    _player = AudioPlayer();
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.black,
    ));
    _init();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(AudioSessionConfiguration.speech());
    // Listen to errors during playback.
    _player.playbackEventStream.listen((event) {},
        onError: (Object e, StackTrace stackTrace) {
      print('A stream error occurred: $e');
    });
    try {
      await _player.setAudioSource(_playlist);
    } catch (e) {
      // Catch load errors: 404, invalid url ...
      print("Error loading playlist: $e");
    }
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  // Stream<PositionData> get _positionDataStream =>
  //   Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
  //       _player.positionStream,
  //       _player.bufferedPositionStream,
  //       _player.durationStream,
  //       (position, bufferedPosition, duration) => PositionData(
  //           position, bufferedPosition, duration ?? Duration.zero));
  
  @override
  Widget build(BuildContext context) {
    final urlW = ['https://api.whatsapp.com/send?phone=555533291263', 'https://api.whatsapp.com/send?phone=555535373440', 'https://api.whatsapp.com/send?phone=554936480233', 'https://api.whatsapp.com/send?phone=554934351007', 'https://api.whatsapp.com/send?phone=554936470707', 'https://api.whatsapp.com/send?phone=554933254355', 'https://api.whatsapp.com/send?phone=554736251406', 'https://api.whatsapp.com/send?phone=554936470707'];
    
    return new WillPopScope(
      onWillPop: () async => false, 
      child: new MaterialApp(
      
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Container(
          decoration: new BoxDecoration(
            image: new DecorationImage(image: AssetImage("assets/img/MobilePlayer.png"), fit: BoxFit.cover),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: StreamBuilder<SequenceState?>(
                  stream: _player.sequenceStateStream,
                  builder: (context, snapshot) {
                    final state = snapshot.data;
                    if (state?.sequence.isEmpty ?? true) return SizedBox();
                    final metadata = state!.currentSource!.tag as MediaItem;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child:
                                Center(
                                  child: Image.network(metadata.artUri.toString(),
                                        scale: 1.5,   
                                  ),
                                ),
                          ),
                        ),
                        // Text(metadata.album,
                        //     style: Theme.of(context).textTheme.headline6),
                        // Text(metadata.title),
                      ],
                    );
                  },
                ),
              ),
              ControlButtons(_player),
              // StreamBuilder<PositionData>(
              //   stream: _positionDataStream,
              //   builder: (context, snapshot) {
              //     final positionData = snapshot.data;
              //     return SeekBar(
              //       duration: positionData?.duration ?? Duration.zero,
              //       position: positionData?.position ?? Duration.zero,
              //       bufferedPosition:
              //           positionData?.bufferedPosition ?? Duration.zero,
              //       onChangeEnd: (newPosition) {
              //         _player.seek(newPosition);
              //       },
              //     );
              //   },
              // ),
              SizedBox(height: 8.0),
              Row(
                children: [

                ],
              ),
              Container(
                height: 300.0,
                color: Colors.transparent,
                child: StreamBuilder<SequenceState?>(
                  stream: _player.sequenceStateStream,
                  builder: (context, snapshot) {
                    if(!snapshot.hasData) return SizedBox();
                    final state = snapshot.data;
                    final sequence = state?.sequence ?? [];
                    final metadata = state!.currentSource!.tag as MediaItem; 
                    return ListView(
                      children: [
                        for (var i = 0; i < sequence.length; i++)
                          Dismissible(
                            key: ValueKey(sequence[i]),
                            background: Container(
                              color: Colors.transparent,
                              alignment: Alignment.centerRight,
                              child: Padding(
                                padding: const EdgeInsets.only(right: 8.0),
                                child: Icon(Icons.delete, color: Colors.transparent),
                              ),
                            ),
                            onDismissed: (dismissDirection) {
                              _playlist.removeAt(i);
                            },
                            child: Material(
                              color: i == state.currentIndex
                                  ? Colors.transparent
                                  : Colors.transparent,    
                              child: Card(
                                color: Colors.transparent,
                                shape: StadiumBorder(
                                   side: BorderSide(
                                     color: i == state.currentIndex
                                          ? Colors.yellow
                                          : Colors.white,
                                     width: 1.0,
                                   ),
                                ),
                                child: ListTile(
                                title: Text(sequence[i].tag.title as String,
                                style: GoogleFonts.lato(
                                  textStyle: TextStyle(color: i == state.currentIndex
                                          ? Colors.yellow
                                          : Colors.white,
                                          fontSize: 20.0,
                                          fontWeight: FontWeight.w700,
                                      ),
                                ),
                                textAlign: TextAlign.center,      
                                    ),
                                onTap: () {
                                  _player.seek(Duration.zero, index: i);
                                },
                                leading: Wrap(
                                  children: <Widget>[
                                    IconButton(icon: i == state.currentIndex 
                                    ? Icon(Icons.pause, color: i == state.currentIndex
                                          ? Colors.yellow
                                          : Colors.white,)
                                    : Icon(Icons.play_arrow,
                                    color: i == state.currentIndex
                                          ? Colors.yellow
                                          : Colors.white,), 
                                    onPressed: (){
                                      _player.seek(Duration.zero, index: i);
                                      i == state.currentIndex
                                      ? _player.pause()
                                      : _player.play();
                                    }         
                                    ),
                                  ],
                                ),
                                trailing: Wrap(
                                  children: <Widget>[
                                    IconButton(icon: Icon(FontAwesomeIcons.whatsapp,
                                    color: i == state.currentIndex
                                          ? Colors.yellow
                                          : Colors.white,), 
                                    onPressed: () async => await launch(urlW[i])
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AfterSplash extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
      title: new Text("Welcome In SplashScreen Package"),
      automaticallyImplyLeading: false
      ),
      body: new Center(
        child: new Text("Done!",
        style: new TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30.0
        ),),

      ),
    );
  }
}

class ControlButtons extends StatelessWidget {
  final AudioPlayer player;

  ControlButtons(this.player);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: Icon(Icons.skip_previous),
            color: Colors.yellow,
            onPressed: player.hasPrevious ? player.seekToPrevious : null,
          ),
        ),
        StreamBuilder<PlayerState>(
          stream: player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: Icon(Icons.play_arrow),
                iconSize: 64.0,
                color: Colors.yellow,
                onPressed: player.play,
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: Icon(Icons.pause),
                iconSize: 64.0,
                color: Colors.yellow,
                onPressed: player.pause,
              );
            } else {
              return IconButton(
                icon: Icon(Icons.replay),
                iconSize: 25.0,
                color: Colors.yellow,
                onPressed: () => player.seek(Duration.zero,
                    index: player.effectiveIndices!.first),
              );
            }
          },
        ),
        StreamBuilder<SequenceState?>(
          stream: player.sequenceStateStream,
          builder: (context, snapshot) => IconButton(
            icon: Icon(Icons.skip_next),
            color: Colors.yellow,
            onPressed: player.hasNext ? player.seekToNext : null,
          ),
        ),
      ],
    );
  }
}

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;

  SeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
  });

  @override
  _SeekBarState createState() => _SeekBarState();
}

class _SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SliderTheme(
          data: _sliderThemeData.copyWith(
            thumbShape: HiddenThumbComponentShape(),
            activeTrackColor: Colors.transparent,
            inactiveTrackColor: Colors.transparent,
          ),
          child: ExcludeSemantics(
            child: Slider(
              min: 0.0,
              max: widget.duration.inMilliseconds.toDouble(),
              value: widget.bufferedPosition.inMilliseconds.toDouble(),
              onChanged: (value) {
                setState(() {
                  _dragValue = value;
                });
                if (widget.onChanged != null) {
                  widget.onChanged!(Duration(milliseconds: value.round()));
                }
              },
              onChangeEnd: (value) {
                if (widget.onChangeEnd != null) {
                  widget.onChangeEnd!(Duration(milliseconds: value.round()));
                }
                _dragValue = null;
              },
            ),
          ),
        ),
        SliderTheme(
          data: _sliderThemeData.copyWith(
            inactiveTrackColor: Colors.transparent,
          ),
          child: Slider(
            min: 0.0,
            max: widget.duration.inMilliseconds.toDouble(),
            value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(),
                widget.duration.inMilliseconds.toDouble()),
            onChanged: (value) {
              setState(() {
                _dragValue = value;
              });
              if (widget.onChanged != null) {
                widget.onChanged!(Duration(milliseconds: value.round()));
              }
            },
            onChangeEnd: (value) {
              if (widget.onChangeEnd != null) {
                widget.onChangeEnd!(Duration(milliseconds: value.round()));
              }
              _dragValue = null;
            },
          ),
        ),
        Positioned(
          right: 16.0,
          bottom: 0.0,
          child: Text(
              RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                      .firstMatch("$_remaining")
                      ?.group(1) ??
                  '$_remaining',
              style: Theme.of(context).textTheme.caption),
        ),
      ],
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

void _showSliderDialog({
  required BuildContext context,
  required String title,
  required int divisions,
  required double min,
  required double max,
  String valueSuffix = '',
  required Stream<double> stream,
  required ValueChanged<double> onChanged,
}) {
  showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title, textAlign: TextAlign.center),
      content: StreamBuilder<double>(
        stream: stream,
        builder: (context, snapshot) => Container(
          height: 100.0,
          child: Column(
            children: [
              Text('${snapshot.data?.toStringAsFixed(1)}$valueSuffix',
                  style: TextStyle(
                      fontFamily: 'Fixed',
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0)),
              Slider(
                divisions: divisions,
                min: min,
                max: max,
                value: snapshot.data ?? 1.0,
                onChanged: onChanged,
              ),
            ],
          ),
        ),
      ),
    ),
  );
}

class AudioMetadata {
  final String album;
  final String title;
  final String artwork;
  final String wpp;
  final String id;

  AudioMetadata(
      {required this.album, required this.title, required this.artwork, required this.wpp, required this.id});
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;

  PositionData(this.position, this.bufferedPosition);
}
