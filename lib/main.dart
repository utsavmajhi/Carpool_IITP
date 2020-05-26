import 'package:carpool/ConfirmAddTravelScreen.dart';
import 'package:flutter/material.dart';
import 'package:carpool/LoginScreen.dart';
import 'package:carpool/PasswordResetScreen.dart';
import 'package:carpool/WelcomePage.dart';
import 'package:carpool/RegistrationScreen.dart';
import 'package:carpool/HomeScreen.dart';
import 'package:carpool/addtravelwaypoint.dart';
import 'package:carpool/addtravelTo.dart';

void main() {
  runApp(Carpool());
}

class Carpool extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute:LoginScreen.id,
      routes: {
        WelcomePage.id:(context) => WelcomePage(),
        LoginScreen.id:(context) => LoginScreen(),
        RegistrationScreen.id:(context) => RegistrationScreen(),
        PasswordResetScreen.id:(context) => PasswordResetScreen(),
        HomeScreen.id:(context) => HomeScreen(),
        AddTravelWaypoint.id:(context) => AddTravelWaypoint(),
        AddTravelTo.id:(context) => AddTravelTo(),
        ConfirmAddTravelScreen.id:(context) => ConfirmAddTravelScreen(),

      },
    );
  }
}
