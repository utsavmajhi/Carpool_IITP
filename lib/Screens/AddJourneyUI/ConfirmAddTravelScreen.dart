import 'package:carpool/Screens/HomeScreen.dart';
import 'package:carpool/Screens/AddJourneyUI/addtravelTo.dart';
import 'package:flutter/material.dart';
import 'file:///G:/FlutterApps/carpool/lib/Screens/PasswordResetScreen.dart';
import 'file:///G:/FlutterApps/carpool/lib/Screens/RegistrationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'file:///G:/FlutterApps/carpool/lib/Utils/constants.dart';
import 'file:///G:/FlutterApps/carpool/lib/Utils/rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carpool/PassArguments/AddtravelDetails.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';

String _username="default";
final _firestore=Firestore.instance;
FirebaseUser loggedInUser;

class ConfirmAddTravelScreen extends StatefulWidget {
  static String id='ConfirmAddTravel_screen';

  @override
  _ConfirmAddTravelScreenState createState() => _ConfirmAddTravelScreenState();
}

class _ConfirmAddTravelScreenState extends State<ConfirmAddTravelScreen> {

@override
  void initState(){
    super.initState();
    getCurrentUser();
    getvaluesfromshared();
    _phonecontroller = TextEditingController(text:_phonenumber);


  }

Future<bool> getvaluesfromshared() async
{
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  String username=sharedPreferences.getString('username');
  _username=username;
  String defaultphn=sharedPreferences.getString('userphone');
  _phonenumber=defaultphn;
  setState(() {
    _phonecontroller = TextEditingController(text:_phonenumber);
  });

  return true;
}

void getCurrentUser () async{ try{
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
  GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  bool showSpinner=false;
  String _phonenumber;
  String _journeytime = '00:00';
  String _nofpersonsaccom='0';
  DateTime _dateTime=DateTime.now();
  TextEditingController _phonecontroller;
  //snackbar initialises
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
    AddtravelDetails addtravelDetails=ModalRoute.of(context).settings.arguments;
    var size =MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: size.height*.34,
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
                              fontSize: 35
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
                              child: addtravelDetails.selectTravelType=="TO" ? Image.asset("images/right.png"): Image.asset("images/leftarrow.png") ,
                            ),
                          )
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          CircleAvatar(
                              radius: (38),
                              backgroundColor: Colors.transparent,
                              child: ClipRRect(
                                borderRadius:BorderRadius.circular(20),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: addtravelDetails.selectModeoftravel=="Railways" ? Image.asset("images/trainicon.png"):Image.asset("images/plane.png"),
                                ),
                              )
                          ),
                          addtravelDetails.selectTravelType=="TO"?Text(addtravelDetails.selectTo,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),):Text(addtravelDetails.selectFrom,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),



                        ],
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: addtravelDetails.selectTravelType=="TO"?
                          Text('Select Departure time: ', style: GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.w700),):Text('Select Arrival time: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700, fontFamily: 'Montserrat Medium'),),
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
                              style: GoogleFonts.lora(
                                color: Colors.blueAccent,
                                fontSize: 20,
                                fontWeight: FontWeight.w600
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
                            style: GoogleFonts.lora(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,

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
                          child: Container(
                            width: 200,
                            child: Text(
                              'No of person accompanying (excluding you) : ',
                              style: GoogleFonts.lora(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w600,

                              ),
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
                            style: GoogleFonts.lora(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,

                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left:35),
                            child: TextFormField(
                              keyboardType: TextInputType.phone,
                              controller: _phonecontroller,
                              style: TextStyle(
                                fontSize: 20
                              ),
                              textAlign: TextAlign.end,
                              onChanged: (value)
                              {
                                //get the phone number
                                _phonenumber=value;
                              },
                              decoration:InputDecoration(
                                //errorText:  ? 'Value Can\'t Be Empty' : null,
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
                          String check=checks(addtravelDetails.selectFrom,_dateTime.toString(),_journeytime,_phonenumber,addtravelDetails.selectModeoftravel);
                          if(check=="Checks passed")
                            {
                              setState(() {
                                showSpinner=true;
                              });
                              String uid=loggedInUser.uid;
                              try{

                                String documentid=uid + _dateTime.day.toString()+_dateTime.month.toString()+_dateTime.year.toString()+_journeytime.replaceFirst(RegExp(':'), 'z')+addtravelDetails.selectTo+addtravelDetails.selectFrom;
                                var parsedDate = DateTime.parse('2020-01-01 $_journeytime:00.000');
                               await _firestore.collection("events").document(documentid).setData({
                                  'description':addtravelDetails.selectTravelType,
                                  'event_date': _dateTime,
                                  'id':documentid,
                                  'title': '_dateTime',
                                  'placefrom' : addtravelDetails.selectFrom,
                                  'placeto': addtravelDetails.selectTo,
                                  'modeofj': addtravelDetails.selectModeoftravel,
                                  'timeofj': parsedDate,
                                  'phone':_phonenumber,
                                  'nofpeople':_nofpersonsaccom,
                                  'creatoruid':uid,
                                  'creatorname': _username,
                                }).whenComplete(() {
                                  _showSnackBar("Successfully Added", Colors.green);

                                  Future.delayed(const Duration(milliseconds: 2000), () {
                                      // Here you can write your code
                                    setState(() {
                                      // Here you can write your code for open new view
                                      Navigator.pushAndRemoveUntil(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => HomeScreen()
                                          ),
                                          ModalRoute.withName("/home_screen")
                                      );
                                    });

                                  });
                                }).then((value) => Firestore.instance.collection('events').orderBy('timeofj'));
                                setState(() {
                                  showSpinner=false;
                                });
                              }
                              catch(e)
                                  {
                                    setState(() {
                                      showSpinner=false;
                                    });
                                    _showSnackBar(e.message, Colors.red[700]);
                                    print(e+"in ConfirmAddtravelScreen DATABASE ERROR");

                                  }

                            }
                          else//error
                            {
                              setState(() {
                                showSpinner=false;

                              });
                              _showSnackBar(check, Colors.red[700]);
                            }


                    },),
                  ),

                ],
              )
            ],
          ),
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

String checks(@required String placefrom,@required String dateoj, @required String timeofj,@required String phn,@required String modeofj)
{
  if(phn.isEmpty||phn==null)
    {
      return "All Fields are Mandatory";
    }
  else
    {
      if(modeofj.isEmpty||modeofj==null)
        {
          return "Error ! Retry from start";
        }
      else
        {
          if(dateoj.isEmpty||dateoj==null)
            {
              return "Please fill all the details";
            }
          else
            {
              if(DateTime.parse(dateoj).isAfter(DateTime.now().subtract(new Duration(days: 1)))){
                return "Checks passed";
              }
              else{
                return "Past Dates not allowed";
              }

            }
        }
    }
}