import 'package:carpool/Screens/BrowseCalendarUI/CalenderUI.dart';
import 'package:carpool/Screens/EditJourneyUI/EditTravelScreen.dart';
import 'package:carpool/Screens/LoginScreen.dart';
import 'package:carpool/Screens/AddJourneyUI/addtravelwaypoint.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:carpool/Utils/rounded_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:carpool/PassArguments/edittraveluidargs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:strings/strings.dart';


class HomeScreen extends StatefulWidget {

  static String id='home_screen';
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String user_name="User";
  String uid="";
  final _auth = FirebaseAuth.instance;
  TextEditingController changeusername = TextEditingController();
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
        changeusername=new TextEditingController(text: username);
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
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[
                                  Text(
                                    user_name,
                                    style: TextStyle(
                                        fontFamily: 'Montserrat Medium',
                                        color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  GestureDetector(

                                    onTap: (){
                                      showModalBottomSheet<void>(
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (BuildContext context) {

                                          return SingleChildScrollView(
                                            child: Container(
                                              child: Center(
                                                child: Column(
                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                  mainAxisSize: MainAxisSize.min,
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:  EdgeInsets.only(
                                                          bottom: MediaQuery.of(context).viewInsets.bottom),
                                                      child: Padding(
                                                        padding: const EdgeInsets.all(20.0),
                                                        child: TextFormField(
                                                          controller: changeusername,
                                                          textAlign: TextAlign.start,
                                                          decoration: InputDecoration(
                                                            contentPadding: EdgeInsets.only(
                                                                left: 15, bottom: 11, top: 11, right: 15),
                                                            labelText: 'New Username',
                                                            prefixIcon: Icon(Icons.person),
                                                            labelStyle: TextStyle(
                                                              color: Color(0xFFB2BCC8),
                                                              fontWeight: FontWeight.w600,
                                                              fontSize: 17,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(left:18.0,right: 18,top: 0,bottom: 10),
                                                      child: RoundedButton(
                                                        title: "Update",
                                                        colour: Color(0xFF3F6AFE),
                                                        onPressed: (){
                                                          setState(()async{
                                                            if(changeusername.text.isEmpty){
                                                              _showSnackBar(
                                                                  'Please type new username',
                                                                  Colors.red[600]);
                                                              Navigator.pop(context);
                                                            }
                                                            else{
                                                              await Firestore.instance.collection('UsersData').document(uid).updateData({
                                                                "username":capitalize(changeusername.text)
                                                              }).whenComplete((){
                                                                _showSnackBar("Successfully Updated username",Colors.blueAccent);
                                                                updatesharedprefs(capitalize(changeusername.text)).then((value){
                                                                  setState(() {
                                                                    user_name=capitalize(changeusername.text);
                                                                    Navigator.pop(context);
                                                                  });
                                                                });

                                                              });
                                                            }



                                                          });

                                                        },
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: Icon(Icons.mode_edit,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  )
                                ],
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
                        childAspectRatio: (1/1),
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
                                            child: SvgPicture.asset('images/travel2.svg',height: 110,
                                            fit: BoxFit.contain,)),
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
                                        child: SvgPicture.asset('images/pencil.svg',height: 100,
                                            fit: BoxFit.contain)),
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
                                          child: SvgPicture.asset('images/calendar.svg',height: 100,
                                              fit: BoxFit.contain)),
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
                                    SvgPicture.asset('images/taxi.svg',height: 110,
                                        fit: BoxFit.contain),
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
                         // Navigator.pushReplacementNamed(context, LoginScreen.id);
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => LoginScreen()
                              ),
                              ModalRoute.withName("/Login_screen")
                          );
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

  Future<bool> updatesharedprefs(String username) async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    await sharedPreferences.setString('username', username);
    sharedPreferences.commit();
    return true;

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

