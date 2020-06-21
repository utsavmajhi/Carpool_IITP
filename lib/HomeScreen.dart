import 'package:carpool/CalenderUI.dart';
import 'package:carpool/EditTravelScreen.dart';
import 'package:carpool/LoginScreen.dart';
import 'package:carpool/addtravelwaypoint.dart';
import 'package:flutter/material.dart';
import 'package:carpool/PasswordResetScreen.dart';
import 'package:carpool/RegistrationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carpool/constants.dart';
import 'package:carpool/rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'PassArguments/edittraveluid.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


class HomeScreen extends StatefulWidget {
  static String id='home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String user_name="User";
  String uid="";
  final _auth = FirebaseAuth.instance;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   getvaluesfromshared();
  }
  //snackbar initialises
  GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  _showSnackBar(@required String message, @required Color colors) {
      if(_scaffoldKey!=null)
      {
        _scaffoldKey.currentState.showSnackBar(
          SnackBar(
            backgroundColor: colors,
            content: new Text(message),
            duration: new Duration(seconds: 4),
          ),
        );
      }

  }
  void getvaluesfromshared() async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String username=sharedPreferences.getString('username');
    String useruid=sharedPreferences.getString('UID');
    print(username);
    setState(() {
      if(user_name!=null){
        user_name= username;
        uid=useruid;
      }

      });
  }
  //sigout from firebase auth
  _signOut() async {
    await _auth.signOut();
  }
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      extendBodyBehindAppBar: true,
        body: Stack(
          alignment: Alignment.topRight,
          children: <Widget>[

            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: size.height*.36,
                decoration: BoxDecoration(
                  color: Color(0xFF355AFE),
                ),

              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: <Widget>[
                    Container(
                      height: 64,
                      margin: EdgeInsets.only(bottom: 20),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                            CircleAvatar(
                              radius: 32,
                                backgroundImage: AssetImage('images/dummypro.png'),
                            ),
                          SizedBox(
                            width: 16,
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Hi !',
                                style: TextStyle(
                                  fontFamily: 'Montserrat Medium',
                                  color: Colors.white,
                                  fontSize: 25
                                ),
                              ),
                              Text(
                                user_name,
                                style: TextStyle(
                                    fontFamily: 'Montserrat Medium',
                                    color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),


                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Expanded(
                      child: GridView.count(
                        mainAxisSpacing: 35,
                          crossAxisSpacing: 22,
                          primary: false,
                          children: <Widget>[
                            InkWell(
                              onTap: ()
                              {
                                //goto next screen of addtravel
                                Navigator.pushNamed(context, AddTravelWaypoint.id);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 4,
                                    child: Column(

                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Hero(tag: 'AddTravelHero',
                                            child: SvgPicture.asset('images/travel2.svg',height: 110,)),
                                        SizedBox(
                                          height: 10 ,
                                        ),
                                        Text(
                                          'Add Journey',
                                          style: TextStyle(
                                              fontFamily: 'Montserrat Regular',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w700,
                                              color: Color.fromRGBO(63, 63, 63, 1)
                                          ),
                                        ),


                                      ],
                                    ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                Navigator.pushNamed(context, EditTravelScreen.id,arguments:EditTravelUid(uid: uid) );
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 4,
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Hero(tag: "Edit Travel Plan",
                                        child: SvgPicture.asset('images/pencil.svg',height: 100,)),
                                    SizedBox(
                                      height: 20 ,
                                    ),
                                    Text(
                                      'Edit Journey',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat Regular',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(63, 63, 63, 1)
                                      ),
                                    ),

                                  ],
                                ),
                              ),
                            ),

                            InkWell(
                              onTap: (){
                                //goto calendar screen
                                Navigator.pushNamed(context, CalenderUI.id);

                              },
                              child: Padding(
                                padding: const EdgeInsets.all(0.0),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  elevation: 4,
                                  child: Column(

                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Hero(tag: 'CalenderHero',
                                          child: SvgPicture.asset('images/calendar.svg',height: 100,)),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Text(
                                        'Browse Calender',
                                        style: TextStyle(
                                            fontFamily: 'Montserrat Regular',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w700,
                                            color: Color.fromRGBO(63, 63, 63, 1)
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: (){
                                _showSnackBar("Coming Soon! Stay tuned",Colors.blue);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                elevation: 4,
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SvgPicture.asset('images/taxi.svg',height: 110,),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      'Cab Drivers',
                                      style: TextStyle(
                                          fontFamily: 'Montserrat Regular',
                                          fontSize: 16,
                                          fontWeight: FontWeight.w700,
                                          color: Color.fromRGBO(63, 63, 63, 1)
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),

                          ],
                          crossAxisCount: 2,
                      ),
                    ),

                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15,vertical: 40),
              child: IconButton(
                alignment: Alignment.topRight,
                onPressed: () async{

                  Alert(
                    context: context,
                    type: AlertType.warning,
                    title: "Warning",
                    desc: "You will be Logged Out",
                    buttons: [
                      DialogButton(
                        child: Text(
                          "Log Out!",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: ()async {
                          _signOut();//signout from firebase
                          SharedPreferences preferences = await SharedPreferences.getInstance();
                          await preferences.clear();
                          Navigator.pushReplacementNamed(context, LoginScreen.id);
                        },
                        color: Colors.red[600],
                      ),
                      DialogButton(
                        child: Text(
                          "Cancel",
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                        onPressed: () => Navigator.pop(context),
                        color: Colors.blueAccent,
                      )
                    ],
                  ).show();
                },
                icon:Icon(Icons.exit_to_app,size: 35,color: Colors.white,),
              ),
            ),

          ],
        ),
    );
  }
}
class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path=Path();
    path.lineTo(0.0,size.height-40);
    path.quadraticBezierTo(size.width/4, size.height, size.width/2, size.height);
    path.quadraticBezierTo(size.width-(size.width/4), size.height, size.width, size.height-40);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }

}

