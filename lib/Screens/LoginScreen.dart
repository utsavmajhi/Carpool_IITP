import 'file:///G:/FlutterApps/carpool/lib/Screens/HomeScreen.dart';
import 'file:///G:/FlutterApps/carpool/lib/Screens/ForgetPasswordSheet.dart';
import 'file:///G:/FlutterApps/carpool/lib/Screens/RegistrationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'file:///G:/FlutterApps/carpool/lib/Utils/constants.dart';
import 'file:///G:/FlutterApps/carpool/lib/Utils/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carpool/firebaseServices/Crud.dart';
import 'package:strings/strings.dart';



FirebaseUser loggedInUser;
class LoginScreen extends StatefulWidget {
  static String id = 'login_screen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with TickerProviderStateMixin {
  final scaffoldState = GlobalKey<ScaffoldState>();

  crudMethods crudObj=new crudMethods();

  GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  bool showSpinner = false;
  final _auth = FirebaseAuth.instance;
  String email="";
  final resetemail = TextEditingController();
  String _validate;
  String password="";
  DocumentSnapshot userdetails;
  bool _obscureText = true;
  bool passwordVisible;
  //for toggling password view

  //snackbar initialises
  _showSnackBar(@required String message, @required Color colors) {
    if (_scaffoldKey != null) {
      _scaffoldKey.currentState.showSnackBar(
        SnackBar(
          backgroundColor: colors,
          content: new Text(message),
          duration: new Duration(seconds: 4),
        ),
      );
    }
  }

  @override
  void initState() {
    passwordVisible = false;
    getCurrentUser();
  }
  void getCurrentUser () async{
    try{
      final user=await _auth.currentUser();
      if(user!=null&&(user.isEmailVerified==true))
      {
        loggedInUser=user;
        Navigator.pushReplacementNamed(context, HomeScreen.id);

      }
    }
    catch(e)
    {
      print(e);
    }

  }

  Widget buildbottomSheet;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipPath(
                clipper: MyClipper(),
                child: Container(
                  height: 260,
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
                            child: Hero(
                              tag: 'Splashicon',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image.asset("images/appicon.png"),
                                ),
                              ),
                            )),
                      ),
                      Center(
                        child: Text(
                          'Welcome',
                          style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 45),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 20, right: 30, bottom: 20),
                child: TextFormField(
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    //get the email
                    email = value;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    labelText: 'Institute Email',
                    prefixIcon: Icon(Icons.email),
                    labelStyle: TextStyle(
                      color: Color(0xFFB2BCC8),
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 30, top: 10, right: 30, bottom: 20),
                child: TextFormField(
                  obscureText: _obscureText,
                  textAlign: TextAlign.start,
                  onChanged: (value) {
                    //get the pass
                    password = value;
                  },
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.only(
                        left: 15, bottom: 11, top: 11, right: 15),
                    labelText: 'Password',
                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                          color: Colors.grey),
                      onPressed: () {
                        setState(() {
                          passwordVisible = !passwordVisible;
                          _obscureText = !_obscureText;
                        });
                      },
                    ),
                    labelStyle: TextStyle(
                      color: Color(0xFFB2BCC8),
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      //Navigate to forgot password page
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: () {


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
                                              controller: resetemail,
                                              textAlign: TextAlign.start,
                                              decoration: InputDecoration(
                                                contentPadding: EdgeInsets.only(
                                                    left: 15, bottom: 11, top: 11, right: 15),
                                                labelText: 'Enter your Registered Institute ID',
                                                prefixIcon: Icon(Icons.email),
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
                                            title: "Send Reset Link",
                                            colour: Color(0xFF3F6AFE),
                                            onPressed: (){
                                              setState(()async{
                                                if(resetemail.text.isEmpty||(!resetemail.text.contains("@iitp"))){
                                                  _showSnackBar(
                                                    'Please enter your Registered Institute Id',
                                                    Colors.red[600]);
                                                  Navigator.pop(context);
                                                }
                                                else{
                                                  _validate="notempty";
                                                  //checks completed and passed
                                                  //backend starts
                                                  String check=await firebasepasswordreset(resetemail.text,_auth);
                                                  if(check=="ResetLinkSent")
                                                    {
                                                      _showSnackBar(
                                                          'Password Reset link has been sent to ${resetemail.text}',
                                                          Colors.green);
                                                      Navigator.pop(context);
                                                    }else
                                                      {
                                                        _showSnackBar(check,
                                                            Colors.red[600]);
                                                        Navigator.pop(context);
                                                      }


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
                        child: Text(
                          'Forgot Password?',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF2E50FF),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RoundedButton(
                      title: 'Login',
                      colour: Color(0xFF3F6AFE),
                      onPressed: () async {
                        //backends starts

                        String check = checkparameters(
                            email.toLowerCase().trim(), password);
                        if (check == "Checks passed") {
                          setState(() {
                            showSpinner = true;
                          });
                          try {
                            var user = await _auth.signInWithEmailAndPassword(
                                email: email.toLowerCase().trim(),
                                password: password);
                            var _authenticatedUser = await _auth.currentUser();
                            if (await _authenticatedUser.isEmailVerified) {
                              print("Email is :" +
                                  _authenticatedUser.isEmailVerified
                                      .toString());
                              var document = await Firestore.instance.document('UsersData/'+_authenticatedUser.uid).get();
                               String username=document.data['username'];
                               String institutemail=document.data['institutemail'];
                               String phone=document.data['Phone'];
                               String altemail=document.data['Alternatemail'];

                               //setting values to shared preferences
                               String mcheck= await setsharedprefs(username,phone,institutemail,altemail,_authenticatedUser.uid);
                               if(await mcheck=="true")
                                 {
                                   Navigator.pushReplacementNamed(context, HomeScreen.id);
                                 }


                              // await _showSnackBar('Email is verified',Colors.lightGreen);
                              setState(() {
                                showSpinner = false;
                              });
                            } else {
                              print("Email is :" +
                                  _authenticatedUser.isEmailVerified
                                      .toString());
                              _showSnackBar(
                                  'Email is not verified ! Please verify your email',
                                  Colors.red[600]);
                              setState(() {
                                showSpinner = false;
                              });
                            }
                          } catch (e) {
                            _showSnackBar(e.message, Colors.red[600]);
                            print(e);
                            setState(() {
                              showSpinner = false;
                            });
                          }
                        } else {
                          setState(() {
                            showSpinner = false;
                          });
                          _showSnackBar(check, Colors.red[700]);
                        }
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'New User ?',
                            style: TextStyle(
                                color: Color(0xFFB2BCC8),
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                          GestureDetector(
                            onTap: () {
                              //goto registration page
                              Navigator.pushNamed(
                                  context, RegistrationScreen.id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                    color: Color(0xFF2E50FF),
                                    fontSize: 16,
                                    fontWeight: FontWeight.w600),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

//credentials checks
String checkparameters(
    @required String institutemail, @required String password) {
  if (institutemail.isEmpty ||
      password.isEmpty ||
      institutemail == null ||
      password == null) {
    return "All Fields are Mandatory";
  } else {
    if (password.length < 6) {
      return "Password Length is less than 6";
    } else {
      if (!(institutemail.contains("@iitp"))) {
        return "Please ! Use Webmail Id for Institute Email";
      } else {
        return "Checks passed";
      }
    }
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();
    path.lineTo(0.0, size.height - 40);
    path.quadraticBezierTo(
        size.width / 4, size.height, size.width / 2, size.height);
    path.quadraticBezierTo(size.width - (size.width / 4), size.height,
        size.width, size.height - 40);
    path.lineTo(size.width, 0.0);
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return false;
  }
}
//firebae password reset
Future<String> firebasepasswordreset(@required String email,FirebaseAuth _auth) async{
  try{
    await _auth.sendPasswordResetEmail(email: email);
    print("password reset link has been sent to: "+email);
    return "ResetLinkSent";
  }
  catch(e)
  {
    return e.message;

  }


}



//shared preferences
Future<String> setsharedprefs(String username,String phone,String instiemail,String altemail,String uid) async
{
  SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
  await sharedPreferences.setString('username', username);
  await sharedPreferences.setString('userphone', phone);
  await sharedPreferences.setString('userinstimail', phone);
  await sharedPreferences.setString('useralternatemail', altemail);
  await sharedPreferences.setString('UID', uid);
  sharedPreferences.commit();
  return "true";

}