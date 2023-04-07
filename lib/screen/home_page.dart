import 'package:flutter/material.dart';
import 'package:rest_api/services/user_api.dart';
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
  //....use init state for fatch the data.......//
  @override
   void initState() {
    super.initState();
    fatchUsers();
  }
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
            title: Text(user.fulName),
            subtitle: Text(user.phone),
          );
        },
      ),
   //   ...........Floating Action button is now call into the setState.........//

      floatingActionButton: FloatingActionButton(
        onPressed: fatchUsers,
        child: const Icon(
          Icons.add, // replace with the desired icon
          size: 38.0, // set the size of the icon
        ),
      ),
    );
  }
  //...........create a function for call the User list

  Future<void> fatchUsers() async {
    final response = await UserApi.fatchUsers();
    setState(() {
      users = response;
    });
  }
}
