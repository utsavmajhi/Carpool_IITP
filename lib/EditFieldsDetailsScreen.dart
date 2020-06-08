import 'package:carpool/HomeScreen.dart';
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
import 'package:carpool/PassArguments/AddtravelDetails.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'PassArguments/editdetailsmodel.dart';
import 'roundedbuttonsmall.dart';
import 'package:rflutter_alert/rflutter_alert.dart';


String _username="default";
final _firestore=Firestore.instance;
FirebaseUser loggedInUser;
class EditFieldsDetailsScreen extends StatefulWidget {
  static String id='Editfieldsdetail_Screen';
  @override
  _EditFieldsDetailsScreenState createState() => _EditFieldsDetailsScreenState();
}

class _EditFieldsDetailsScreenState extends State<EditFieldsDetailsScreen> {
  final _auth=FirebaseAuth.instance;
  GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  bool showSpinner=false;
  String _phonenumber;
  TextEditingController _phonecontroller;
  String _nofpersonsaccom;
  String _typeofjourney;
  String _eventrefrenceid;
  String _placeto="IIT Patna";
  String _placefrom="Patna Airport";
  DateTime _dateTime;
  String _journeytime;
@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCurrentUser();
    getvaluesfromshared();
    Future.delayed(Duration.zero,(){
      EditdetailsModel editdetailsModel=ModalRoute.of(context).settings.arguments;
      setState(() {
        _journeytime = changetimeformat(editdetailsModel.documentSnapshot['timeofj']);
        Timestamp timestamp=editdetailsModel.documentSnapshot['event_date'];
        _dateTime=timestamp.toDate();
        _nofpersonsaccom=editdetailsModel.documentSnapshot['nofpeople'].toString();
        _phonecontroller=TextEditingController(text:editdetailsModel.documentSnapshot['phone']);
        _phonenumber=editdetailsModel.documentSnapshot['phone'];
        _typeofjourney=editdetailsModel.documentSnapshot['description'];
        _placefrom=editdetailsModel.documentSnapshot['placefrom'];
        _placeto=editdetailsModel.documentSnapshot['placeto'];
        _eventrefrenceid=editdetailsModel.documentSnapshot['id'];
      });

    });
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
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
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
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        actions: <Widget>[

        ],
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
                                  child: SvgPicture.asset('images/pencil.svg'),
                                ),
                              ),
                            )
                        ),
                      ),
                      Center(
                        child: Text(
                          'Edit Journey',
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text('From : ', style: GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.w700),),
                        ),
                        DropdownButton<String>(
                          value: _placefrom,
                          iconSize: 10,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              _placefrom=newValue;
                            });
                          },
                          items: <String>['Patna Junction','Patna Airport','Danapur Junction','Patliputra Junction','Ara Junction','Rajendra Nagar Terminal','IIT Patna']
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
                          child: Text('To : ', style: GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.w700),),
                        ),
                        DropdownButton<String>(
                          value: _placeto,
                          iconSize: 10,
                          elevation: 16,
                          style: TextStyle(color: Colors.deepPurple),
                          onChanged: (String newValue) {
                            setState(() {
                              _placeto=newValue;
                            });
                          },
                          items: <String>['Patna Junction','Patna Airport','Danapur Junction','Patliputra Junction','Ara Junction','Rajendra Nagar Terminal','IIT Patna']
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
                  SizedBox(
                    height: 8,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal:18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Flexible(
                          child: Text('Select Depart/Arr time: ', style: GoogleFonts.lora(fontSize: 18, fontWeight: FontWeight.w700),),
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
                              _dateTime==null? "Please Select" : changetimeformatv2(_dateTime),
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
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        RoundedButtonSmall(title: "Update",colour:Color(0xFF3F6AFE),onPressed: (){
                          setState(() {
                            showSpinner=true;
                          });

                          String _newtypeofj;
                          String uid=loggedInUser.uid;
                          String _modeofj;
                          if(_placeto.contains("Airport")||_placefrom.contains("Airport")){_modeofj="Flight";}else{_modeofj="Railways";}
                          var parsedDate = DateTime.parse('2020-01-01 $_journeytime:00.000');
                          String check=checks(_placefrom, _placeto, _dateTime.toString(), _journeytime, _phonenumber, _modeofj);
                          if(check=="Checks passed")
                          {

                            if(_placefrom=="IIT Patna")
                            {
                              _newtypeofj="TO";
                            }
                            else
                            {
                              _newtypeofj="FROM";
                            }

                            try{
                              _firestore.collection('events').document(_eventrefrenceid).updateData({
                                'description':_newtypeofj,
                                'event_date': _dateTime,
                                'title': '_dateTime',
                                'placefrom' : _placefrom,
                                'placeto': _placeto,
                                'modeofj': _modeofj,
                                'timeofj': parsedDate,
                                'phone':_phonenumber,
                                'nofpeople':_nofpersonsaccom,
                                'creatoruid':uid,
                                'creatorname': _username,
                              }).whenComplete((){
                                _showSnackBar("Successfully Updated", Colors.green);
                                Future.delayed(const Duration(milliseconds: 1000), () {
                                  // Here you can write your code
                                  setState(() {
                                    // Here you can write your code for open new view
                                    Navigator.pushReplacementNamed(context, HomeScreen.id);
                                  });

                                });
                              });
                            }
                            catch(e){
                              setState(() {
                                showSpinner=false;
                              });
                              _showSnackBar(e.message, Colors.red[700]);
                              print(e+"in EditFieldsDetailsScreen DATABASE ERROR");
                            }


                          }else//error
                              {
                            setState(() {
                              showSpinner=false;

                            });
                            _showSnackBar(check, Colors.red[700]);
                          }



                        },),
                        SizedBox(
                          width: 15,
                        ),
                        RoundedButtonSmall(title:"Delete",colour: Colors.red[600],onPressed: (){
                              //show alert dialog
                          Alert(
                            context: context,
                            type: AlertType.warning,
                            title: "Warning",
                            desc: "Your entry will be deleted permanently",
                            buttons: [
                              DialogButton(
                                child: Text(
                                  "Do it!",
                                  style: TextStyle(color: Colors.white, fontSize: 20),
                                ),
                                onPressed: () {
                                    showSpinner=true;
                                    Navigator.pop(context);
                                  try{

                                    _firestore.collection('events').document(_eventrefrenceid).delete().whenComplete(() {
                                      _showSnackBar("Successfully Deleted", Colors.green);
                                      Future.delayed(const Duration(milliseconds: 1500), () {
                                        // Here you can write your code
                                        setState(() {
                                          showSpinner=false;
                                          // Here you can write your code for open new view
                                          Navigator.pushReplacementNamed(context, HomeScreen.id);
                                        });

                                      });
                                    });
                                  }catch(e)
                                  {
                                      setState(() {
                                        showSpinner=false;
                                      });
                                      _showSnackBar(e.message+"Please!try again", Colors.red[700]);
                                      Navigator.pushReplacementNamed(context, HomeScreen.id);
                                  }

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
                        },)
                      ],
                    )
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

changetimeformat(@required Timestamp datetimepicked)
{
  String formattedDate = DateFormat('HH:mm').format(datetimepicked.toDate());

  return formattedDate;

}

changetimeformatv2(@required DateTime datetimepicked)
{
  String formattedDate = DateFormat('dd-MM-yyyy').format(datetimepicked);

  return formattedDate;

}
String checks(@required String placefrom,@required String placeto,@required String dateoj, @required String timeofj,@required String phn,@required String modeofj)
{if(placefrom==placeto){
  return("Both 'FROM' places and 'TO' places can't be same");
}
else{
  if(placefrom!="IIT Patna"&&placeto!="IIT Patna")
    {
      return("Path of Journey should be between IIT Patna and any other Junction/airport");
    }
  else
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
            return "Checks passed";
          }
        }
      }
    }
}

}