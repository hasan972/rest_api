import 'dart:convert';

import 'package:rest_api/models/user_dob.dart';
import 'package:rest_api/models/user_location.dart';

import '../models/user.dart';
import '../models/user_name.dart';
import 'package:http/http.dart' as http;

class UserApi {
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
      //......Parse the Date time that's way we store a dbo data into the date vaiable........
      final date = e["dob"]["date"];
      //...........Dob object................
      final dob = UserDob(
        date: DateTime.parse(date),
        age: e["dob"]["age"],
      );
      //.......coordinates object because tehre are two value.......
      final coordinates = LocationCoordinate(
        latitude: e['location']['coordinates']['latitude'],
        longitude: e['location']['coordinates']['longitude'],
      );
      //........ For street..........

      final street = LocationStreet(
        number: e['location']['street']['number'].toString(),
        name: e['location']['street']['name'],
      );
      final timezone = LocationTimezoneCoordinate(
        offset: e['location']['timezone']['offset'],
        description: e['location']['timezone']['description'],
      );

      final location = UserLocation(
          city: e['location']['city'],
          state: e['location']['state'],
          country: e['location']['country'],
          postcode: e['location']['postcode'].toString(),
          street: street,
          coordinates: coordinates,
          timezone: timezone);
      return User(
        gender: e['gender'],
        email: e['email'],
        phone: e['phone'],
        cell: e['cell'],
        nat: e['nat'],
        name: name,
        dob: dob,
        location: location,
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
