import 'package:carpool/PasswordResetScreen.dart';
import 'package:carpool/RegistrationScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carpool/constants.dart';
import 'package:carpool/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';


class LoginScreen extends StatefulWidget {
  static String id='login_screen';


  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with TickerProviderStateMixin{

  GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  bool showSpinner=false;
  final _auth=FirebaseAuth.instance;
  String email;
  String password;

  bool _obscureText = true;
  bool passwordVisible;
  //for toggling password view

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


  @override
  void initState() {
    passwordVisible = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize:  MainAxisSize.min,
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
                            child: ClipRRect(
                              borderRadius:BorderRadius.circular(20),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Image.asset("images/carlogo.png"),
                              ),
                            )
                        ),
                      ),
                      Center(
                        child: Text(
                          'Welcome',
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
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,top: 20,right: 30,bottom: 20),
                child: TextFormField(

                  textAlign: TextAlign.start,
                  onChanged: (value)
                  {
                    //get the email
                    email=value;

                  },
                  decoration:InputDecoration(

                    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
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
                padding: const EdgeInsets.only(left: 30,top: 10,right: 30,bottom: 20),
                child: TextFormField(
                  obscureText: _obscureText,
                  textAlign: TextAlign.start,
                  onChanged: (value)
                  {
                    //get the pass
                    password=value;
                  },
                  decoration:InputDecoration(

                    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    labelText: 'Password',

                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                        passwordVisible?Icons.visibility:Icons.visibility_off,
                          color: Colors.grey
                      ),
                      onPressed: (){
                        setState(() {
                          passwordVisible=!passwordVisible;
                          _obscureText= !_obscureText;
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
                    onTap: ()
                    {
                      //Navigate to forgot password page
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(right: 12),
                      child: GestureDetector(
                        onTap: (){
                          //goto passwordresetScreen
                          Navigator.pushNamed(context, PasswordResetScreen.id);
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
                    RoundedButton(title: 'Login',colour: Color(0xFF3F6AFE),
                      onPressed: () async{
                          //backends starts
                        setState(() {
                          showSpinner=true;
                        });

                        try{
                          var user=await _auth.signInWithEmailAndPassword(email: email.toLowerCase().trim(), password: password);
                          var _authenticatedUser = await _auth.currentUser();
                          if(_authenticatedUser.isEmailVerified)
                          {
                            print("Email is :"+_authenticatedUser.isEmailVerified.toString());
                            /* Navigator.pushNamed(context,HomeScreen.id);*/
                            _showSnackBar('Email is verified',Colors.lightGreenAccent);
                            setState(() {
                              showSpinner=false;
                            });
                          }
                          else
                          {
                            print("Email is :"+_authenticatedUser.isEmailVerified.toString());
                            _showSnackBar('Email is not verified ! Please verify your email',Colors.red[600]);
                            setState(() {
                              showSpinner=false;
                            });
                          }

                        }
                        catch(e)
                        {
                          print(e);
                          setState(() {
                            showSpinner=false;
                          });

                        }



                    },),
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
                              fontWeight: FontWeight.w600
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              //goto registration page
                              Navigator.pushNamed(context, RegistrationScreen.id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Signup',
                                style: TextStyle(
                                  color: Color(0xFF2E50FF),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600
                                ),
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