import 'package:http/http.dart' as http;

class LoginRepository {
  static Map<String,String> cookie={};
  static int time=0;
  login() async {
    var request = http.MultipartRequest(
        'POST',
        Uri.parse(
            'https://rpc.freshdi.com/api/method/freshdi.data.farm_company.login'));
    request.fields.addAll({'usr': '0345678913', 'pwd': 'test2022'});

    // request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
     LoginRepository.cookie={
       'Cookie':response.headers['set-cookie']??''
     };
    } else {
      print(response.reasonPhrase);
    }
  }
}
