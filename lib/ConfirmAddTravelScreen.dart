import 'package:carpool/addtravelTo.dart';
import 'package:flutter/material.dart';
import 'package:carpool/PasswordResetScreen.dart';
import 'package:carpool/RegistrationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carpool/constants.dart';
import 'package:carpool/rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final _firestore=Firestore.instance;
FirebaseUser loggedInUser;

class ConfirmAddTravelScreen extends StatefulWidget {
  static String id='ConfirmAddTravel_screen';

  @override
  _ConfirmAddTravelScreenState createState() => _ConfirmAddTravelScreenState();
}

class _ConfirmAddTravelScreenState extends State<ConfirmAddTravelScreen> {

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
  }
void getCurrentUser () async{
  try{
    final user=await _auth.currentUser();
    if(user!=null)
    {
      loggedInUser=user;

    }
  }
  catch(e)
  {
    print(e);
  }

}
  final _auth=FirebaseAuth.instance;

  final List<String> subjects = ["Computer Science", "Biology", "Math","asdsa","ads","sad","asdsad","sadsadsa","dasdasdsa","asdasdsad"];
  String _journeytime = '00:00';

  String _nofpersonsaccom='0';
DateTime _dateTime=DateTime.now();

//date picker from calendar
  Future<Null> _selectDate(BuildContext context) async {
   final DateTime picked=await showDatePicker(context: context, initialDate: _dateTime, firstDate: DateTime(2016), lastDate: DateTime(2222));
   if(picked!=null && picked !=_dateTime)
     {

       setState(() {
         _dateTime=picked;
       });
     }
  }

  //String time=DateFormat('yMd').format(_dateTime);
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            ClipPath(
              clipper: MyClipper(),
              child: Container(
                height: size.height*.38,
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
                        'Confirm Travel',
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      children: <Widget>[
                        CircleAvatar(
                            radius: (38),
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("images/iitplogo.png"),
                              ),
                            )
                        ),
                        Text(
                          'IIT Patna',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          ),
                        )
                      ],
                    ),
                    CircleAvatar(
                        radius: (29),
                        backgroundColor: Colors.transparent,
                        child: ClipRRect(
                          borderRadius:BorderRadius.circular(20),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset("images/right.png"),
                          ),
                        )
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                            radius: (38),
                            backgroundColor: Colors.transparent,
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("images/trainicon.png"),
                              ),
                            )
                        ),
                        Text(
                          'Rajendranagar',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),
                        Text(
                          'Terminal',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                          ),
                        ),

                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'Select Train Departure : ',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Montserrat Medium'
                          ),
                        ),
                      ),
                      DropdownButton<String>(
                        value: _journeytime,
                        icon: Icon(Icons.access_time),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            _journeytime = newValue;
                          });
                        },
                        items: <String>['00:00', '00:30', '01:00', '01:30','02:00', '02:30','03:00', '03:30','04:00', '04:30','05:00', '05:30','06:00', '06:30','07:00', '07:30','08:00', '08:30','09:00', '09:30','10:00', '10:30','11:00', '11:30','12:00', '13:30','14:00', '14:30','15:00', '15:30','16:00', '16:30','17:00', '17:30','18:00', '18:30','19:00', '19:30','20:00', '20:30','21:00', '21:30','22:00', '22:30','23:00', '23:30']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                            style: TextStyle(
                              color: Colors.blueAccent,
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[

                      Flexible(
                        child: Text(
                          'Select Journey Date : ',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Montserrat Medium'
                          ),
                        ),
                      ),
                      Flexible(
                        child: FlatButton(
                          onPressed: (){
                                _selectDate(context);
                          },
                          child: Text (
                            _dateTime==null? "Please Select" : changetimeformat(_dateTime),
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.blueAccent,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 6,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Flexible(
                        child: Text(
                          'No of person accompanying (excluding you) : ',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Montserrat Medium'
                          ),
                        ),
                      ),
                      DropdownButton<String>(
                        value: _nofpersonsaccom ,
                        icon: Icon(Icons.group),
                        iconSize: 24,
                        elevation: 16,
                        style: TextStyle(color: Colors.deepPurple),
                        underline: Container(
                          height: 2,
                          color: Colors.deepPurpleAccent,
                        ),
                        onChanged: (String newValue) {
                          setState(() {
                            _nofpersonsaccom = newValue;
                          });
                        },
                        items: <String>['0','1','2','3']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value,
                              style: TextStyle(
                                  color: Colors.blueAccent,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold
                              ),),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:18.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Text(
                          'Phone Number : ',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'Montserrat Medium'
                          ),
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(left:35),
                          child: TextFormField(
                            style: TextStyle(
                              fontSize: 20
                            ),
                            textAlign: TextAlign.end,
                            onChanged: (value)
                            {
                              //get the pass
                            },
                            decoration:InputDecoration(
                              contentPadding: EdgeInsets.only(left: 0, bottom: 1, top: 11, right: 15),

                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom:18.0),
                  child: RoundedButton(title: 'Submit',colour: Color(0xFF3F6AFE),
                    onPressed: () async{
                        String uid=loggedInUser.uid;
                      _firestore.collection("events").document(uid + _dateTime.millisecondsSinceEpoch.toString()+_journeytime.replaceFirst(RegExp(':'), '0')).setData({
                        'description':"new item",
                        'event_date': _dateTime,
                        'id':"yoyo",
                        'title': '_dateTime',

                      });
                  },),
                ),

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

//for formatting date
changetimeformat(@required DateTime datetimepicked)
{
  String formattedDate = DateFormat('dd-MM-yyyy').format(datetimepicked);
  return formattedDate;
  
}