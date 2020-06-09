import 'package:carpool/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carpool/constants.dart';
import 'package:carpool/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
final _firestore=Firestore.instance;
class RegistrationScreen extends StatefulWidget {
  static String id='registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> with TickerProviderStateMixin{
  GlobalKey<ScaffoldState> _scaffoldKey= new GlobalKey<ScaffoldState>();
  final _auth=FirebaseAuth.instance;
  bool showSpinner=false;
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool passwordVisible;
  bool passwordVisible2;
  //for toggling password view
  //Storing variables
  String _institutemail;
  String _password1;
  String _passwordconfirm;
  String _fullname;
  String _phonenum;
  String _altemail;




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
    passwordVisible2 = false;
  }


  @override
  Widget build(BuildContext context) {

    return ModalProgressHUD(
      inAsyncCall: showSpinner,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
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

                      Center(
                        child: Text(
                          'Create Account',
                          style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 40
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
              Padding(
                padding: const EdgeInsets.only(left: 30,top: 8,right: 30,bottom: 20),
                child: TextFormField(

                  textAlign: TextAlign.start,
                  onChanged: (value)
                  {
                    //get the fullname
                    _fullname=value;
                  },
                  decoration:InputDecoration(

                    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    labelText: 'Full Name',
                    prefixIcon: Icon(Icons.person_pin),
                    labelStyle: TextStyle(
                      color: Color(0xFFB2BCC8),
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,top:8,right: 30,bottom: 20),
                child: TextFormField(

                  textAlign: TextAlign.start,
                  onChanged: (value)
                  {
                    //get the institute email
                    _institutemail=value;
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
                padding: const EdgeInsets.only(left: 30,top:8,right: 30,bottom: 20),
                child: TextFormField(

                  textAlign: TextAlign.start,
                  onChanged: (value)
                  {
                    //get the alternate email
                    _altemail=value;
                  },
                  decoration:InputDecoration(

                    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    labelText: 'Alternate Email',
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
                padding: const EdgeInsets.only(left: 30,top: 8,right: 30,bottom: 20),
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  textAlign: TextAlign.start,
                  onChanged: (value)
                  {
                    //get the phone number
                    _phonenum=value;
                  },
                  decoration:InputDecoration(

                    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    labelText: 'Phone Number',
                    prefixIcon: Icon(Icons.phone),
                    labelStyle: TextStyle(
                      color: Color(0xFFB2BCC8),
                      fontWeight: FontWeight.w600,
                      fontSize: 17,
                    ),

                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 30,top: 8,right: 30,bottom: 20),
                child: TextFormField(
                  obscureText: _obscureText,
                  textAlign: TextAlign.start,
                  onChanged: (value)
                  {
                    //get the pass
                    _password1=value;
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
              Padding(
                padding: const EdgeInsets.only(left: 30,top:8,right: 30,bottom: 20),
                child: TextFormField(
                  obscureText: _obscureText2,
                  textAlign: TextAlign.start,
                  onChanged: (value)
                  {
                    //get the confirm password
                    _passwordconfirm=value;
                  },
                  decoration:InputDecoration(

                    contentPadding: EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
                    labelText: 'Confirm Password',

                    prefixIcon: Icon(Icons.lock),
                    suffixIcon: IconButton(
                      icon: Icon(
                          passwordVisible2?Icons.visibility:Icons.visibility_off,
                          color: Colors.grey
                      ),
                      onPressed: (){
                        setState(() {
                          passwordVisible2=!passwordVisible2;
                          _obscureText2= !_obscureText2;
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
              Flexible(
                fit: FlexFit.loose,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    RoundedButton(title: 'Sign up',colour: Color(0xFF3F6AFE),
                      onPressed: () async{
                      //backend starts for registration

                        //checks to be performed
                         String checks=checkparameters(_fullname,_institutemail.toLowerCase().trim(),_altemail.toLowerCase().trim(),_phonenum,_password1,_passwordconfirm);
                         if(checks=="Checks passed")
                           {
                             setState(() {
                               showSpinner=true;
                             });
                             try{
                               final  newUser=await _auth.createUserWithEmailAndPassword(email: _institutemail.toLowerCase().trim(), password: _password1);
                               var _authenticatedUser = await _auth.currentUser();
                               await _authenticatedUser.sendEmailVerification();
                             if(await newUser!=null)
                               {
                                 String uid=_authenticatedUser.uid;
                                 //Navigator.pushNamed(context, ChatScreen.id);
                                  //firestore datacollection starts
                                 await _firestore.collection('UsersData').document(uid).setData({
                                   'username':_fullname,
                                   'institutemail':_institutemail.toLowerCase().trim(),
                                   'Alternatemail':_altemail.toLowerCase().trim(),
                                   'Phone':_phonenum,
                                   'Extra1':"default",
                                   'Extra2':"default",
                                 });
                                  setState(() {
                                    showSpinner=false;
                                  });

                                 _showSnackBar("Verification Mail has been sent to provided Institute mail Id", Colors.lightGreen);
                               }
                             }
                             catch(e)
                             {
                               setState(() {
                                 showSpinner=false;
                               });
                               _showSnackBar(e.toString(),Colors.red[700]);
                               print(e);
                             }
                           }
                         else
                           {
                             setState(() {
                               showSpinner=false;
                             });
                             _showSnackBar(checks, Colors.red[700]);
                           }



                    },),
                    Padding(
                      padding: const EdgeInsets.all(26.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'Already have an account ?',
                            style: TextStyle(
                                color: Color(0xFFB2BCC8),
                                fontSize: 16,
                                fontWeight: FontWeight.w600
                            ),
                          ),
                          GestureDetector(
                            onTap: (){
                              Navigator.pushReplacementNamed(context, LoginScreen.id);
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                'Login',
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

String checkparameters(@required String fullname,@required String institutemail,@required String altemail,@required String phone,@required String pass1,@required String passconf) {
if(fullname.isEmpty||institutemail.isEmpty||altemail.isEmpty||phone.isEmpty||pass1.isEmpty||passconf.isEmpty||fullname==null||institutemail==null||altemail==null||phone==null||pass1==null||passconf==null)
  {
    return "All Fields are Mandatory";
  }
  else
    {
      if(pass1!=passconf||pass1.length<6)
        {
          return "Password do not matched or its length is less than 6";
        }
      else
        {
          if(!(institutemail.contains("@iitp")))
            {
              return "Please ! Use Webmail Id for Institute Email";
            }
          else
            {
              return "Checks passed";
            }
        }
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
