

import 'package:dio/dio.dart';
import 'package:shazam/utils/models/music_model.dart';

class MusicDetectService {

  Future<MusicModel?> detectSound({required String base64string}) async {
    try {
      var response = await Dio().post(
        'https://shazam.p.rapidapi.com/songs/v2/detect',
        data: base64string,
        options: Options(
          headers: {
            'x-rapidapi-host':'shazam.p.rapidapi.com',
            'x-rapidapi-key':'626d13b8damsh0b88914ea74a744p140510jsnfe115cdf8e95'
          },
          contentType: Headers.textPlainContentType
        ),
      );


      if(response.data['track'] != null) {
        return MusicModel.fromJson(response.data['track']);
      } else {
        return null;
      }

    } catch (e) {
      throw Exception(e);
    }
  }

}