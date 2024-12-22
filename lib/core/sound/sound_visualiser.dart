

import 'dart:async';
import 'dart:typed_data';
import 'package:mic_stream/mic_stream.dart';
import 'package:shazam/utils/services/music_detect_service.dart';


class SoundVisualiser {

  late StreamSubscription<List<int>> listener;
  MusicDetectService musicDetectService = MusicDetectService();
  bool isRecord() => listener.isPaused;

  Future<Stream<Uint8List>?> audioStreamListen() async {

    return await MicStream.microphone(
        audioSource: AudioSource.DEFAULT,
        sampleRate: 44100,
        channelConfig: ChannelConfig.CHANNEL_IN_MONO,
        audioFormat: AudioFormat.ENCODING_PCM_16BIT
    );

  }



}