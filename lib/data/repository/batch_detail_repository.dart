import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:my_boilerplate/data/repository/login_repository.dart';

import '../../models/batch.dart';

class BatchDetailRepository {


  Future<Batch?> get() async {
    var headers = LoginRepository.cookie;
    var request = http.MultipartRequest(
        'GET',
        Uri.parse(
            'https://rpc.freshdi.com/api/method/freshdi.data.test.batch.get_batch_detail'));
    request.fields.addAll({'cultivation': 'FTWZV001080209TA'});

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      String data = await response.stream.bytesToString();

      return Batch.fromJson(jsonDecode(data));
    } else {
      print(response.reasonPhrase);
      if (LoginRepository.time == 10) return null;
      LoginRepository.time++;
      await LoginRepository().login();
      return await BatchDetailRepository().get();
    }
  }

  Future<Batch?> batchUpdate(
      {String? cultivation,
      String? typeTran,
      String? tranDate,
      String? mass,
      String? uom,
      String? description}) async {
    var headers = {
      'Content-Type': 'application/json',
      // 'Cookie':
      //     'full_name=Nguy%E1%BB%85n%20V%C4%83n%20A; sid=b45fa2842771ff53fdaca42a5adc42f29e598dd9230cd021d51c683f; system_user=yes; user_id=test%40gmail.com; user_image='
    };
    headers.addAll(LoginRepository.cookie);
    var request = http.Request(
        'POST',
        Uri.parse(
            'https://rpc.freshdi.com/api/method/freshdi.data.test.batch_trans.post_batch_trans'));
    request.body = json.encode({
      "trans_cultivation": cultivation,
      "trans_type": typeTran,
      "trans_date": tranDate,
      "trans_quantity": mass ?? 0,
      "trans_uom": "kg",
      "trans_description": description
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();
    if (response.statusCode == 200) {
      // print(await response.stream.bytesToString());
      String data = await response.stream.bytesToString();

      return Batch.fromJson(jsonDecode(data));
    } else {
      if (LoginRepository.time == 10) return null;
      LoginRepository.time++;
      print(response.reasonPhrase);
      await LoginRepository().login();
      return await BatchDetailRepository().batchUpdate();
    }
  }

}
