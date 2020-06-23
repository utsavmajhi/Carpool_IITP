import 'file:///G:/FlutterApps/carpool/lib/Screens/BrowseCalendarUI/CalenderUI.dart';
import 'package:carpool/Screens/AddJourneyUI/ConfirmAddTravelScreen.dart';
import 'package:carpool/Screens/IntroScreen.dart';
import 'package:flutter/material.dart';
import 'package:carpool/Screens/LoginScreen.dart';
import 'package:carpool/Screens/PasswordResetScreen.dart';
import 'package:carpool/Screens/WelcomePage.dart';
import 'package:carpool/Screens/RegistrationScreen.dart';
import 'package:carpool/Screens/HomeScreen.dart';
import 'package:carpool/Screens/AddJourneyUI/addtravelwaypoint.dart';
import 'package:carpool/Screens/AddJourneyUI/addtravelTo.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'file:///G:/FlutterApps/carpool/lib/Screens/EditJourneyUI/EditTravelScreen.dart';
import 'file:///G:/FlutterApps/carpool/lib/Screens/EditJourneyUI/EditFieldsDetailsScreen.dart';
import 'package:carpool/Screens/SplashScreen.dart';
final _auth = FirebaseAuth.instance;
void main() {
  runApp(Carpool());
}

class Carpool extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      initialRoute:SplashScreen.id,
      routes: {
        WelcomePage.id:(context) => WelcomePage(),
        LoginScreen.id:(context) => LoginScreen(),
        RegistrationScreen.id:(context) => RegistrationScreen(),
        PasswordResetScreen.id:(context) => PasswordResetScreen(),
        HomeScreen.id:(context) => HomeScreen(),
        AddTravelWaypoint.id:(context) => AddTravelWaypoint(),
        AddTravelTo.id:(context) => AddTravelTo(),
        ConfirmAddTravelScreen.id:(context) => ConfirmAddTravelScreen(),
        CalenderUI.id:(context) => CalenderUI(),
        IntroScreen.id:(context) => IntroScreen(),
        EditTravelScreen.id:(context) => EditTravelScreen(),
        EditFieldsDetailsScreen.id:(context) => EditFieldsDetailsScreen(),
        SplashScreen.id:(context) => SplashScreen(),
      },
    );
  }
}
