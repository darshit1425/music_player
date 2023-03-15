import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';

class Music_provider extends ChangeNotifier {
  AssetsAudioPlayer? assetsAudioPlayer;
  bool isMute = false;
  bool isPlay = false;

  void Changevalue() //posh and push
  {
    isPlay = !isPlay; // start stop method
    notifyListeners();
  }

  List<Audio> audioList = [
    Audio("assets/music/OsManLook_At_The_Sky.mp3"),
    Audio("assets/music/Maroon.mp3"),
    Audio("assets/music/music.mp3"),
    Audio("assets/music/Kale.mp3"),
    Audio("assets/music/Badboy.mp3"),
  ];

  Duration totalDurationAudio = Duration(seconds: 0);

  void intiAudio() {
    assetsAudioPlayer = AssetsAudioPlayer();
    assetsAudioPlayer!.open(
      Playlist(audios: audioList),
      autoStart: false,
      showNotification: true,
    );
    totalDurationAudio1();
  }

  Future<void> startAudio() async {
    await assetsAudioPlayer!.play();
  }

  Future<void> stopAudio() async {
    await assetsAudioPlayer!.pause();
  }

  Future<void> MuteOrunmuteAudio() async {
    await assetsAudioPlayer!.setVolume(isMute ? 1 : 0);
    isMute = !isMute;
    notifyListeners();
  }

  void totalDurationAudio1() {
    assetsAudioPlayer!.current.listen(
      (event) {
        totalDurationAudio = event!.audio.duration;
      },
    );
    notifyListeners();
  }

  void nextSong() async {
    await assetsAudioPlayer!.next();
  }

  void backSong() async {
    await assetsAudioPlayer!.previous();
  }
}
