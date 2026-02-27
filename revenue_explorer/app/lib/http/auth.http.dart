import 'package:dio/dio.dart';
import 'package:revenue_explorer/http/client.dart';

// Future<bool> revExLogIn(String email, String password) async {
//   final response = await http.post(
//     Uri.http(revexApiUrl, '/auth/login'),
//     headers: revexDefaultHeaders,
//     body: jsonEncode(<String, String>{
//       'email': email,
//       'password': password,
//     }),
//   );

//   if (response.statusCode != 200) {
//     return false;
//   }

//   await response.captureCookies();
//   return true;
// }

Future<bool> revExLogIn(String email, String password) async {
  try {
    final Response res = await httpClient.post(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return res.statusCode == 200;
  } on DioException {
    return false;
  }
}

Future<void> revExLogOut() async {
  await httpClient.get('/auth/logout');
}

// Future revExLogOut() async {
//   final response = await http.get(
//     Uri.http(revexApiUrl, '/auth/logout'),
//     headers: await revexDefaultHeaders.withCookies(),
//   );
//   await response.captureCookies();
// }
