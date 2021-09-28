
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:weather_project/api/weather_api.dart';
import 'edit_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
          title: Text("Welcome to weather App"),
          centerTitle: true,
          backgroundColor: Colors.lightBlueAccent,
          actions: <Widget>[
            PopupMenuButton(
                icon: Icon(Icons.settings),
                itemBuilder: (context) =>
                [
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.person,),
                      title: Text('Edit profile '),
                      onTap: ()=> Navigator.push(context, MaterialPageRoute(builder: (context) => EditProfile()),),
                    ),
                  ),
                  PopupMenuItem(
                    child: ListTile(
                      leading: Icon(Icons.add_to_home_screen_outlined,),
                      title: Text('Logout'),
                      onTap: ()=>logout(context),
                    ),
                  ),

                ]
            ),
          ]
      ),

    body: FutureBuilder(
      future: getweather(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Text('${snapshot.error} has occurred.'),
          );
        else if (snapshot.hasData) {
          final Weather data = snapshot.data as Weather;
          return ListView.builder(
              itemCount: data.weather.length,
                   itemBuilder: (BuildContext context, int index) {
                     return Column(
                       mainAxisAlignment: MainAxisAlignment.start,
                       children: [
                         Container(
                           width: 200,
                           child: Text('Name: ${data.name}',style: TextStyle(fontSize: 20),),
                         ),
                         Container(
                           width: 200,
                           height: 30,
                           child: Text('Base : ${data.base}',style: TextStyle(fontSize: 20),),
                         ),
                         ListTile(
                           title: Text(
                             'Description: ${data.weather[index].description}',
                             style: TextStyle(fontSize: 20),
                           ),
                           subtitle: Text('Main: ${data.weather[index].main}'),
                         ),
                       ],
                     );
                   });

        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ),
    );
  }

  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}