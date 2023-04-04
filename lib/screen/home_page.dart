import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../models/user.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //......List of dynamic is now list of user because now we use the model for fatch the data....
  //List<dynamic> users = [];
  List<User> users = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Rest Api call'),
      ),
      //add the get code
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          //final email = user.email;
          return ListTile(
            title: Text(user.name.first),
            subtitle: Text(user.phone),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: fatchUserCall,
        child: const Icon(
          Icons.add, // replace with the desired icon
          size: 38.0, // set the size of the icon
        ),
      ),
    );
  }

  void fatchUserCall() async {
    const url = 'https://randomuser.me/api/?results=100';
    final uri = Uri.parse(url);
    final response = await http.get(uri);
    final body = response.body;
    final json = jsonDecode(body);
    final results = json['results'] as List<dynamic>;
    final transformed = results.map((e) {
      //...........Call the user into the variable ........
      final name =
          UserName(title: e['name']['title'], first: e['name']['first'], last: e['name']['last']);
      return User(
        gender: e['gender'],
        email: e['email'],
        phone: e['phone'],
        cell: e['cell'],
        nat: e['nat'],
        name:name,
      );
    }).toList();

    setState(() {
      users = transformed;
    });
    print('Compleate');
  }
}
