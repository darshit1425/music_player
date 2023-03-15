import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/music_provider.dart';

class Music_Screen extends StatefulWidget {
  const Music_Screen({Key? key}) : super(key: key);

  @override
  State<Music_Screen> createState() => _Music_ScreenState();
}

class _Music_ScreenState extends State<Music_Screen> {
  Music_provider? musicProviderT;
  Music_provider? musicProviderF;

  @override
  void initState() {
    super.initState();

    Provider.of<Music_provider>(context, listen: false).intiAudio();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    musicProviderF = Provider.of<Music_provider>(context, listen: false);
    musicProviderT = Provider.of<Music_provider>(context, listen: true);

    return SafeArea(
      child: Scaffold(
        // backgroundColor: Colors.black,
        body: Stack(
          children: [
            Container(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                "assets/image/look.jpg",
                fit: BoxFit.fill,
              ),
            ),
            Container(
              height: double.infinity,
              width: double.infinity,
              color: Colors.black54,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 50,
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    // color: Colors.blue,
                    child: Image.asset(
                      "assets/image/look2.jpg",
                      fit: BoxFit.fill,
                    ),
                  ),
                  SizedBox(
                    height: 55,
                  ),
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed: () {
                          musicProviderF!.stopAudio();
                        },
                        icon: Icon(
                          Icons.stop,
                          color: Colors.red,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      IconButton(
                        onPressed: () {
                          musicProviderF!.Changevalue();
                          if (musicProviderT!.isPlay) {
                            musicProviderF!.startAudio();
                          } else {
                            musicProviderF!.stopAudio();
                          }
                        },
                        icon: Icon(
                          musicProviderT!.isPlay
                              ? Icons.pause
                              : Icons.play_arrow,
                          color: Colors.white,
                          size: 30,
                        ),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      // IconButton(
                      //   onPressed: () {
                      //    musicProviderT!.isMute
                      //   },
                      //   icon: Icon(
                      //     Icons.volume_mute,
                      //     color: Colors.white,
                      //     size: 30,
                      //   ),
                      // ),
                      IconButton(
                        onPressed: () {
                          musicProviderF!.MuteOrunmuteAudio();
                        },
                        icon: Icon(
                          musicProviderT!.isMute
                              ? Icons.volume_off
                              : Icons.volume_up,
                          size: 30,
                        ),
                        color: Colors.redAccent,
                      ),
                      SizedBox(
                        height: 12,
                      ),
                    ],
                  ),
                  PlayerBuilder.currentPosition(
                    player: musicProviderF!.assetsAudioPlayer!,
                    builder: (context, position) => Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Slider(
                            value: position.inSeconds.toDouble(),
                            max: musicProviderF!.totalDurationAudio.inSeconds
                                .toDouble(),
                            onChanged: (value) {
                              musicProviderF!.assetsAudioPlayer!.seek(
                                Duration(
                                  seconds: value.toInt(),
                                ),
                              );
                            },
                            activeColor: Colors.green.shade600,
                            inactiveColor: Colors.greenAccent.shade100,
                          ),
                        ),
                        Row(
                          children: [
                            Text(
                              "${position}",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blueAccent),
                            ),
                            SizedBox(
                              width: 140,
                            ),
                            Text(
                              "${musicProviderF!.totalDurationAudio}",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.blueAccent),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(9),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(
                          onPressed: () {
                            musicProviderF!.backSong();
                          },
                          icon: Icon(
                            Icons.skip_previous_sharp,
                            // color: Color(0xff9FABE5FF),
                            color: Colors.redAccent,
                            size: 40,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            musicProviderF!.nextSong();
                          },
                          icon: Icon(
                            Icons.skip_next_sharp,
                            // color: Color(0xff9FABE5FF),
                            color: Colors.redAccent,

                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
