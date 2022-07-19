import 'dart:async';
import 'dart:core';

import 'package:http/http.dart' as http;

// class Users {
//   num x;
//   num y;
//   Users({
//     required this.x,
//     required this.y,
//   });

//   factory Users.fromJson(Map<String, dynamic> json) => Users(
//         x: json["x"],
//         y: json["y"],
//       );
// }

Stream<List<double>> getDataFromWifi() async* {
  final response = await http.get(
    Uri.parse('https://ankur-iitb.github.io/dummyServer/'),
  );
  if (response.statusCode == 200) {
    String jsonResponse = response.body;
    List<String> result = jsonResponse.split(',');
    List<double> dataList = result.map(double.parse).toList();
    // List<Users> users = [];
    // for (var u in jsonResponse) {
    //   Users user = Users(x: u['x'], y: u['y']);
    //   users.add(user);
    // }
    // return users;

    // print(dataList);
    yield dataList;
    // return jsonResponse;
  } else {
    print("Erorr");
    throw Exception('Failed to load post');
  }
}
