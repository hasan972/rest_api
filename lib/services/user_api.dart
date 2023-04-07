import 'dart:convert';
import '../models/user.dart';
import '../models/user_name.dart';
import 'package:http/http.dart' as http;


class UserApi{
  //........It is fetch user that's way the return type is Future async..........//
  static Future<List<User>> fatchUsers() async {
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final users = results.map((e) {
      //...........Call the user into the variable ........
      final name = UserName(
        title: e['name']['title'],
        first: e['name']['first'],
        last: e['name']['last'],
      );
      return User(
        gender: e['gender'],
        email: e['email'],
        phone: e['phone'],
        cell: e['cell'],
        nat: e['nat'],
        name: name,
      );
    }).toList();
    return users;
//........SetState can't call outside of the statefull widget..........//
    // setState(() {
    //   users = transformed;
    // });
    // print('Compleate');
  }
}

