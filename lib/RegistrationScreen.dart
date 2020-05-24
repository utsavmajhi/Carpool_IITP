import 'package:carpool/LoginScreen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:carpool/constants.dart';
import 'package:carpool/rounded_button.dart';

class RegistrationScreen extends StatefulWidget {
  static String id='registration_screen';
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  bool _obscureText = true;
  bool _obscureText2 = true;
  bool passwordVisible;
  bool passwordVisible2;
  //for toggling password view

  @override
  void initState() {
    passwordVisible = false;
    passwordVisible2 = false;
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  //get the pass
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
                  //get the pass
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
              padding: const EdgeInsets.only(left: 30,top: 8,right: 30,bottom: 20),
              child: TextFormField(
                keyboardType: TextInputType.phone,
                textAlign: TextAlign.start,
                onChanged: (value)
                {
                  //get the pass
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
                  //get the pass
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
                  RoundedButton(title: 'Sign up',colour: Color(0xFF3F6AFE),onPressed: (){

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
                            Navigator.pushNamed(context, LoginScreen.id);
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
