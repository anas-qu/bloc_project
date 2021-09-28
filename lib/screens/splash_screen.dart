import 'package:flutter/material.dart';
import 'dart:async';
import 'package:weather_project/screens/login_screen.dart';



class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);
  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _navigatetohome();
  }

  _navigatetohome()async{
    await Future.delayed(Duration(milliseconds: 3000),(){});
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=> LoginScreen()));
  }
  @override
  Widget build(BuildContext context)
  {
    Size size = MediaQuery.of(context).size;
    return Scaffold
      (
      body:Container(

          width: double.infinity,
          height: double.infinity,
          color: Colors.white,
          child: Center(
            child: Container(
              width: size.width,
              height: size.height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      width: size.width,
                      height: size.height*0.7,
                      decoration: BoxDecoration(
                          shape:  BoxShape.circle
                      ),
                      child: Image.asset('asstes/images/logo1.png')
                  ),

                ],
              ),
            ),
          )
      ),

    );
  }
}