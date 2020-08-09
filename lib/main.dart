import 'package:file_picker/file_picker.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MusicApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: fromfile(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class fromfile extends StatelessWidget {
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.blueGrey.shade400,
        appBar: AppBar(
          title: Text('music'),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Center(
              child: RaisedButton(
                child: Text('listen songs from local file'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HomePage()),
                  );
                },
              ),
            ),
            Center(
              child: RaisedButton(
                colorBrightness: Brightness.light,
                child: Text('listen songs from Network'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyAppAssets()),
                  );
                },
              ),
            ),
            /*Center(
              child: RaisedButton(
                child: Text('listen songs from Assets'),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MyApp3()),
                  );
                },
              ),
            ),*/
          ],
        ));
  }
}

class HomePage extends StatefulWidget {
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentTime = "00:00";
  String completeTime = "00:00";

  @override
  void initState() {
    super.initState();
    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      setState(() {
        currentTime = duration.toString().split(".")[0];
      });
    });
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        completeTime = duration.toString().split(".")[0];
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade300,
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: <Widget>[
          Image.asset(
            "assets/down.jpg",
            fit: BoxFit.contain,
            width: double.infinity,
            height: 500,
          ),
          Container(
            width: 330,
            height: 60,
            decoration: BoxDecoration(
                color: Colors.white70, borderRadius: BorderRadius.circular(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                IconButton(
                  icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                  onPressed: () {
                    if (isPlaying) {
                      _audioPlayer.pause();
                      setState(() {
                        isPlaying = false;
                      });
                    } else {
                      _audioPlayer.resume();
                      setState(() {
                        isPlaying = true;
                      });
                    }
                  },
                ),
                SizedBox(
                  width: 16,
                ),
                IconButton(
                  icon: Icon(Icons.stop),
                  onPressed: () {
                    _audioPlayer.stop();
                    setState(() {
                      isPlaying = false;
                    });
                  },
                ),
                Text(
                  currentTime,
                  style: TextStyle(fontWeight: FontWeight.w700),
                ),
                Text("|"),
                Text(
                  completeTime,
                  style: TextStyle(fontWeight: FontWeight.w300),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.audiotrack),
        onPressed: () async {
          String filePath = await FilePicker.getFilePath();
          int status = await _audioPlayer.play(filePath, isLocal: true);
          if (status == 1) {
            setState(() {
              isPlaying = true;
            });
          }
        },
      ),
    );
  }
}

class MyAppAssets extends StatefulWidget {
  _MyAppAssetsState createState() => _MyAppAssetsState();
}

class _MyAppAssetsState extends State<MyAppAssets> {
  AudioPlayer _audioPlayer = AudioPlayer();
  bool isPlaying = false;
  String currentTime = "00:00";
  String completeTime = "00:00";
  @override
  void initState() {
    super.initState();
    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      setState(() {
        currentTime = duration.toString().split(".")[0];
      });
    });
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        completeTime = duration.toString().split(".")[0];
      });
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Music Player'),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Image.asset(
              "assets/images.jfif",
              fit: BoxFit.contain,
              width: double.infinity,
              height: 500,
            ),
            Container(
              width: 330,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.blue.shade400,
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: () {
                      if (isPlaying) {
                        _audioPlayer.pause();
                        setState(() {
                          isPlaying = false;
                        });
                      } else {
                        _audioPlayer.resume();
                        setState(() {
                          isPlaying = true;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  IconButton(
                    icon: Icon(Icons.stop),
                    onPressed: () {
                      _audioPlayer.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    },
                  ),
                  Text(
                    currentTime,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text("|"),
                  Text(
                    completeTime,
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () {
            _audioPlayer.play(
                'https://www.pmusiq.info/Hindi%20Songs/2020/Street%20Dancer%203D/Illegal%20Weapon%202.0-Pagalworld.Fm.mp3');
            setState(() {
              isPlaying = true;
            });
          },
        ),
      ),
    );
  }
}

class MyApp2 extends StatefulWidget {
  _MyApp2State createState() => _MyApp2State();
}

class _MyApp2State extends State<MyApp2> {
  AudioPlayer _audioPlayer = AudioPlayer();
  //AudioCache _audioPlayer2 = AudioCache();
  bool isPlaying = false;
  String currentTime = "00:00";
  String completeTime = "00:00";
  @override
  void initState() {
    super.initState();
    _audioPlayer.onAudioPositionChanged.listen((Duration duration) {
      setState(() {
        currentTime = duration.toString().split(".")[0];
      });
    });
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        completeTime = duration.toString().split(".")[0];
      });
    });
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Music Players'),
        ),
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: <Widget>[
            Image.asset(
              "assets/fault.jpg",
              fit: BoxFit.contain,
              width: double.infinity,
              height: 500,
            ),
            Container(
              width: 330,
              height: 60,
              decoration: BoxDecoration(
                  color: Colors.yellowAccent.shade100,
                  borderRadius: BorderRadius.circular(50)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: <Widget>[
                  IconButton(
                    icon: Icon(isPlaying ? Icons.pause : Icons.play_arrow),
                    onPressed: () {
                      if (isPlaying) {
                        _audioPlayer.pause();
                        setState(() {
                          isPlaying = false;
                        });
                      } else {
                        _audioPlayer.resume();
                        setState(() {
                          isPlaying = true;
                        });
                      }
                    },
                  ),
                  SizedBox(
                    width: 16,
                  ),
                  IconButton(
                    icon: Icon(Icons.stop),
                    onPressed: () {
                      _audioPlayer.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    },
                  ),
                  Text(
                    currentTime,
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  Text("|"),
                  Text(
                    completeTime,
                    style: TextStyle(fontWeight: FontWeight.w300),
                  ),
                ],
              ),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow),
          onPressed: () {
            _audioPlayer.play('assets/');
            setState(() {
              isPlaying = true;
            });
          },
        ),
      ),
    );
  }
}

class MyApp3 extends StatelessWidget {
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Video Players'),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.only(left: 45, top: 15),
                width: double.infinity,
                height: 300,
                //margin: 50,
                //child: Card(
                //color: Colors.blueGrey,
                //child: Image.asset('images/down.jpg'),
                //elevation: 50,
                //),
              ),
              Container(
                alignment: Alignment.centerLeft,
                width: 100,
                height: 50,
                color: Colors.blueAccent,
                child: RaisedButton(
                  onPressed: () {
                    var player = VideoPlayerController.network(
                        'https://youtu.be/VrxvJ_ORNBo');
                    player.play();
                  },
                  child: Card(
                    color: Colors.blueAccent,
                    child: Text('click here '),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
