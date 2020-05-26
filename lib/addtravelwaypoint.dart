import 'package:carpool/addtravelTo.dart';
import 'package:flutter/material.dart';
import 'package:carpool/PasswordResetScreen.dart';
import 'package:carpool/RegistrationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carpool/constants.dart';
import 'package:carpool/rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'PassArguments/traveltype.dart';


class AddTravelWaypoint extends StatefulWidget {
  static String id='addtravelwaypoint';

  @override
  _AddTravelWaypointState createState() => _AddTravelWaypointState();
}

class _AddTravelWaypointState extends State<AddTravelWaypoint> {
  @override
  Widget build(BuildContext context) {

    var size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: size.height*.36,
                  decoration: BoxDecoration(
                    /*image: DecorationImage(
                        image: AssetImage('images/back1.jpg'),
                        fit: BoxFit.cover,
                      ),*/
                    color: Color(0xFF355AFE),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: CircleAvatar(
                            radius: (38),
                            backgroundColor: Colors.white,
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: SvgPicture.asset('images/travel2.svg'),
                                ),
                              ),
                            )
                        ),
                      ),
                      Center(
                        child: Text(
                          'Travel Type',
                          style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 45
                          ),
                        ),
                      ),
                    ],
                  ),

                ),
              ),
              SizedBox(
                height: 20,
              ),
              Column(
                children: <Widget>[
                  Center(
                    child: Text(
                      'Choose the type of travel ?',
                      style: GoogleFonts.lora(
                        fontSize: 18,
                        fontWeight: FontWeight.w700
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InkWell(
                      onTap: (){
                        //clicked on 1st button(to)
                        Navigator.pushNamed(context, AddTravelTo.id,arguments:TravelType(selectTravelType: "TO") );
                      },
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  CircleAvatar(
                                      radius: (38),
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius:BorderRadius.circular(20),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset("images/school.png"),
                                        ),
                                      )
                                  ),
                                  Text('IIT Patna'),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  CircleAvatar(
                                      radius: (28),
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius:BorderRadius.circular(20),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset("images/right.png"),
                                        ),
                                      )
                                  ),
                                  Text('TO',style: TextStyle(fontWeight: FontWeight.bold),),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  CircleAvatar(
                                      radius: (38),
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius:BorderRadius.circular(20),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Image.asset("images/airportrail.png"),
                                        ),
                                      )
                                  ),
                                  Text('Airport/Junction'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: InkWell(
                      onTap: (){
                        //clicked on 2nd button (from)
                        Navigator.pushNamed(context, AddTravelTo.id,arguments:TravelType(selectTravelType: "FROM") );
                      },
                      child: Card(
                        elevation: 5,
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              Column(
                                children: <Widget>[
                                  CircleAvatar(
                                      radius: (38),
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius:BorderRadius.circular(20),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset("images/school.png"),
                                        ),
                                      )
                                  ),
                                  Text('IIT Patna'),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  CircleAvatar(
                                      radius: (28),
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius:BorderRadius.circular(20),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Image.asset("images/leftarrow.png"),
                                        ),
                                      )
                                  ),
                                  Text('FROM',style: TextStyle(fontWeight: FontWeight.bold),),
                                ],
                              ),
                              Column(
                                children: <Widget>[
                                  CircleAvatar(
                                      radius: (38),
                                      backgroundColor: Colors.white,
                                      child: ClipRRect(
                                        borderRadius:BorderRadius.circular(20),
                                        child: Padding(
                                          padding: const EdgeInsets.all(2.0),
                                          child: Image.asset("images/airportrail.png"),
                                        ),
                                      )
                                  ),
                                  Text('Airport/Junction'),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
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