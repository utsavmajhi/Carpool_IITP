import 'package:flutter/material.dart';
import 'package:carpool/PasswordResetScreen.dart';
import 'package:carpool/RegistrationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carpool/constants.dart';
import 'package:carpool/rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  static String id='home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
        body: Stack(
          alignment: Alignment.topCenter,
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
                                'Utsav',
                                style: TextStyle(
                                    fontFamily: 'Montserrat Medium',
                                    color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                ),
                              )
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
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 4,
                                child: Column(

                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    SvgPicture.asset('images/travel2.svg',height: 110,),
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
                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 4,
                              child: Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset('images/pencil.svg',height: 100,),
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

                            Card(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              elevation: 4,
                              child: Column(

                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  SvgPicture.asset('images/calendar.svg',height: 100,),
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
                            Card(
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

                          ],
                          crossAxisCount: 2,
                      ),
                    ),

                  ],
                ),
              ),
            )

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