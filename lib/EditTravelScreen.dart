import 'package:carpool/EditFieldsDetailsScreen.dart';
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
import 'PassArguments/edittraveluid.dart';
import 'package:responsive_widgets/responsive_widgets.dart';
import 'package:auto_size_text/auto_size_text.dart';

final _firestore=Firestore.instance;
final FirebaseAuth _auth=FirebaseAuth.instance;
String _userUID="";
class EditTravelScreen extends StatefulWidget {
  static String id='Edit_travelScreen';
  @override
  _EditTravelScreenState createState() => _EditTravelScreenState();
}

class _EditTravelScreenState extends State<EditTravelScreen> {

  @override
  void initState() {
    super.initState();
    //getvaluesfromshared();
  }
  Future<String> getvaluesfromshared() async
  {
    SharedPreferences sharedPreferences=await SharedPreferences.getInstance();
    String userUID=sharedPreferences.getString('UID');
    _userUID=userUID;
    return _userUID;
  }
  @override
  Widget build(BuildContext context) {
    ResponsiveWidgets.init(context);
    var size =MediaQuery.of(context).size;
    EditTravelUid editTravelUid=ModalRoute.of(context).settings.arguments;
    
    return ResponsiveWidgets.builder(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        extendBodyBehindAppBar: true,
        body: StreamBuilder<QuerySnapshot>(
          stream: _firestore.collection("events").where('creatoruid',isEqualTo:editTravelUid.uid).orderBy('event_date').snapshots(),
          builder: (context,snapshot){
            if(!snapshot.hasData)
              {
                  return Center(
                    child: Text('Loading!'),
                  );
              }
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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

                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Hero(
                          tag: 'Edit Travel Plan',
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
                      ),
                      Center(
                        child: Text(
                          'Edit Travel Plans',
                          style: GoogleFonts.raleway(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 38
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
                  Text(
                    'Select the Entry you want to edit',
                    style: GoogleFonts.lora(
                        fontSize: 16,
                        fontWeight: FontWeight.w700
                    ),),

                ],
              ),
             SizedBox(
               height: 10,
             ),
              Expanded(
                child: MediaQuery.removePadding(
                      removeTop: true,
                  removeBottom: true,
                  context: context,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListView.builder(
                        itemCount: snapshot.data.documents.length,
                        itemBuilder: (context,index){
                          Timestamp doj=snapshot.data.documents[index]['event_date'];
                          String dayofj=doj.toDate().day.toString();
                          String monthofj=monthnameconversion(doj);
                          String yearofj=doj.toDate().year.toString();
                          String placefrom=snapshot.data.documents[index]['placefrom'];
                          String placeto=snapshot.data.documents[index]['placeto'];
                          String descriptionoj=snapshot.data.documents[index]['description'];
                          Timestamp firebasetimestamp=snapshot.data.documents[index]['timeofj'];
                          DateTime journeytime=firebasetimestamp.toDate();
                          return InkWell(
                            onTap: ()
                            {
                              //goto next page for editing details
                              print(snapshot.data.documents[index]);
                              Navigator.pushReplacementNamed(context, EditFieldsDetailsScreen.id,arguments:EditdetailsModel(documentSnapshot: snapshot.data.documents[index]));
                            },
                            child: Card(
                              color: Colors.amber,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Flexible(
                                      flex: 1,
                                      child: Column(
                                        children: <Widget>[
                                          Text(dayofj,
                                            style: TextStyle(
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold
                                            ),),
                                          Text(
                                            monthofj,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                            ),
                                          ),
                                          Text(
                                            yearofj,
                                            style: TextStyle(
                                                fontSize: 16,
                                                fontWeight: FontWeight.bold
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      flex: 3,
                                      child: Row(
                                        children: <Widget>[

                                          Text(
                                            descriptionoj=="TO"?placefrom:placeto,
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600
                                            ),
                                          ),
                                          CircleAvatar(
                                              radius: (16),
                                              backgroundColor: Colors.transparent,
                                              child: ClipRRect(
                                                borderRadius:BorderRadius.circular(20),
                                                child: Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: descriptionoj=="TO"?Image.asset("images/right.png"):Image.asset("images/leftarrow.png"),
                                                ),
                                              )
                                          ),
                                            Expanded(
                                              child: Text(
                                              descriptionoj=="TO"?placeto:placefrom,
                                                maxLines: 2,
                                                overflow: TextOverflow.clip,
                                              style: TextStyle(
                                                  fontSize: 15,
                                                  fontWeight: FontWeight.w600
                                              ),
                                          ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                      flex: 1,
                                      child: Padding(
                                        padding: const EdgeInsets.only(top:3.0,right: 0),
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          children: <Widget>[
                                            Text(
                                              descriptionoj=='TO'?'Depart':'Arrival',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Text(
                                                changetimeformat(journeytime),
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: Colors.green,
                                                    fontWeight: FontWeight.w600
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  ),
                ),
              )
            ],
          );
          }
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

String monthnameconversion(@required Timestamp timestamp){
  switch(timestamp.toDate().month)
  {
    case 1:return "Jan";
      break;
    case 2:return "Feb";
      break;
      case 3:return "Mar";
          break;
    case 4:return "April";
      break;
    case 5:return "May";
      break;
    case 6:return "Jun";
      break;
    case 7:return "July";
      break;
    case 8:return "Aug";
      break;
    case 9:return "Sept";
      break;
    case 10:return "Oct";
      break;
    case 11:return "Nov";
      break;
    case 12:return "Dec";
      break;
  }
}
changetimeformat(@required DateTime datetimepicked)
{
  String formattedDate = DateFormat('HH:mm').format(datetimepicked);

  return formattedDate;

}