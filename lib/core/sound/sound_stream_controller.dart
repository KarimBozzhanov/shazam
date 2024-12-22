import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mic_stream/mic_stream.dart';
import 'package:shazam/utils/models/music_model.dart';
import 'package:shazam/utils/services/music_detect_service.dart';

class SoundStreamController {

  late StreamSubscription<List<int>> listener;
  MusicDetectService musicDetectService = MusicDetectService();
  bool recording = false;
  bool get isRecord => recording;

  Future<MusicModel?> listen(BuildContext context) async {

    recording = true;
    /// Stream Init
    Stream<Uint8List>? stream = await MicStream.microphone(
      audioSource: AudioSource.DEFAULT,
      sampleRate: 44100,
      channelConfig: ChannelConfig.CHANNEL_IN_MONO,
      audioFormat: AudioFormat.ENCODING_PCM_16BIT
    );

    /// List of bytes
    var soundBytes = BytesBuilder();

    /// Listen stream
    listener = stream!.listen((samples) {
      print(samples);
      soundBytes.add(samples);
    });

    MusicModel? musicModel;


    /// After 5 seconds stop record
    await Future.delayed(const Duration(seconds: 8), () async {

      /// Stop
      listener.cancel();
      /// Call request to detect service
      musicModel = await musicDetectService.detectSound(base64string: base64Encode(soundBytes.toBytes()));

    });

    return musicModel;
  }

  /// Stop method
  Future stop() async {
    listener.cancel();
  }
}