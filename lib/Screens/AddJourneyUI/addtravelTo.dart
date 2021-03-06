import 'file:///G:/FlutterApps/carpool/lib/Screens/AddJourneyUI/ConfirmAddTravelScreen.dart';
import 'package:carpool/PassArguments/AddtravelDetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:carpool/PassArguments/traveltype.dart';

class AddTravelTo extends StatefulWidget {
  static String id='AddTravel_TO';

  @override
  _AddTravelToState createState() => _AddTravelToState();
}

class _AddTravelToState extends State<AddTravelTo> {


  @override
  Widget build(BuildContext context) {
    TravelType travelType=ModalRoute.of(context).settings.arguments;
    var size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: <Widget>[
          Column(
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
                              travelType.selectTravelType=="TO"?"Destination":"Starting Point",
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
                ],
          ),
          SizedBox(
            height: 6,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                travelType.selectTravelType=="TO"?'Select the Destination':'Select the Starting Point',
                style: GoogleFonts.lora(
                    fontSize: 18,
                    fontWeight: FontWeight.w700
                ),
              ),
            ),
          ),
          Expanded(
            child: showListWidget(travelType.selectTravelType,context)
          )
        ],
      ),
    );
  }
}

class destinationlistitems extends StatelessWidget {
    String destinationname;
    String Distance;
    final Function onTap;
    int colornum;
    String iconimage;
  destinationlistitems({@required this.destinationname,@required this.Distance,@required this.onTap,@required this.iconimage,@required this.colornum});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal : 8.0),
      child: InkWell(
        onTap: onTap,
        child: Card(
          color: colornum==1?Colors.blueAccent[400]:Colors.white,
          elevation: 5,
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Expanded(
                  child: Column(
                    children: <Widget>[
                      Text(
                          '$destinationname',
                        style: GoogleFonts.vollkorn(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: colornum==1?Colors.white:Colors.black,
                        ),
                      ),
                      Text(
                          'Distance : $Distance Km',
                        style: TextStyle(
                          color: colornum==1?Colors.white:Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                CircleAvatar(
                    radius: (38),
                    backgroundColor: Colors.transparent,
                    child: ClipRRect(
                      borderRadius:BorderRadius.circular(20),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.asset("images/$iconimage",color:colornum==1?Colors.white:Colors.black),
                      ),
                    )
                ),

              ],
            ),
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


Widget showListWidget(@required String traveltype, BuildContext context)
{
  if(traveltype=="TO")
    {
      return
        ListView(

          padding: EdgeInsets.all(0),
          children: <Widget>[
            destinationlistitems(destinationname: 'Patna Airport',Distance: "32",
                onTap: () {
              print(traveltype +'Patna Airport');
              Navigator.pushNamed(context, ConfirmAddTravelScreen.id,arguments:AddtravelDetails(selectTravelType: "TO",selectFrom: "IIT Patna",selectTo: "Patna Airport",selectModeoftravel: "Flight") );
            },iconimage: "plane.png",colornum: 0,),
            destinationlistitems(destinationname: 'Ara Junction',Distance: "86",onTap: ()
            {print(traveltype +'Ara Junction');
            Navigator.pushNamed(context, ConfirmAddTravelScreen.id,arguments:AddtravelDetails(selectTravelType: "TO",selectFrom: "IIT Patna",selectTo: "Ara Junction",selectModeoftravel: "Railways") );},iconimage: "trainicon.png",colornum: 1,),
            destinationlistitems(destinationname: 'Danapur Junction',Distance: "26",onTap: ()
            {print(traveltype +'Danapur Junction');
            Navigator.pushNamed(context, ConfirmAddTravelScreen.id,arguments:AddtravelDetails(selectTravelType: "TO",selectFrom: "IIT Patna",selectTo: "Danapur Junction",selectModeoftravel: "Railways") );},iconimage: "trainicon.png",colornum: 0,),
            destinationlistitems(destinationname: 'Patna Junction',Distance: "34",onTap: ()
            {print(traveltype+'Patna Junction');
            Navigator.pushNamed(context, ConfirmAddTravelScreen.id,arguments:AddtravelDetails(selectTravelType: "TO",selectFrom: "IIT Patna",selectTo: "Patna Junction",selectModeoftravel: "Railways") );},iconimage: "trainicon.png",colornum: 1,),
            destinationlistitems(destinationname: 'Patliputra Junction',Distance: "29",onTap: ()
            {print(traveltype+'Patliputra Junction');
            Navigator.pushNamed(context, ConfirmAddTravelScreen.id,arguments:AddtravelDetails(selectTravelType: "TO",selectFrom: "IIT Patna",selectTo: "Patliputra Junction",selectModeoftravel: "Railways") );},iconimage: "trainicon.png",colornum: 0,),
            destinationlistitems(destinationname: 'Rajendra Nagar Terminal',Distance: "39",onTap: ()
            {print(traveltype +'Rajendra Nagar Terminal');
            Navigator.pushNamed(context, ConfirmAddTravelScreen.id,arguments:AddtravelDetails(selectTravelType: "TO",selectFrom: "IIT Patna",selectTo: "Rajendranagar Terminal",selectModeoftravel: "Railways") );},iconimage: "trainicon.png",colornum: 1,),



          ],
        );
    }
  else//for traveltype==FROM
    {
       return ListView(
        padding: EdgeInsets.all(0),
        children: <Widget>[
          destinationlistitems(destinationname: 'Patna Airport',Distance: "32",onTap: ()
          {print(traveltype +'Patna Airport');
          Navigator.pushNamed(context, ConfirmAddTravelScreen.id,arguments:AddtravelDetails(selectTravelType: "FROM",selectFrom: "Patna Airport",selectTo: "IIT Patna",selectModeoftravel: "Flight") );},iconimage: "plane.png",colornum: 0),
          destinationlistitems(destinationname: 'Ara Junction',Distance: "86",onTap: ()
          {print(traveltype +'Ara Junction');
          Navigator.pushNamed(context, ConfirmAddTravelScreen.id,arguments:AddtravelDetails(selectTravelType: "FROM",selectFrom: "Ara Junction",selectTo: "IIT Patna",selectModeoftravel: "Railways") );},iconimage: "trainicon.png",colornum: 1),
          destinationlistitems(destinationname: 'Danapur Junction',Distance: "26",onTap: ()
          {print(traveltype +'Danapur Junction');
          Navigator.pushNamed(context, ConfirmAddTravelScreen.id,arguments:AddtravelDetails(selectTravelType: "FROM",selectFrom: "Danapur Junction",selectTo: "IIT Patna",selectModeoftravel: "Railways") );},iconimage: "trainicon.png",colornum: 0),
          destinationlistitems(destinationname: 'Patna Junction',Distance: "34",onTap: ()
          {print(traveltype+'Patna Junction');
          Navigator.pushNamed(context, ConfirmAddTravelScreen.id,arguments:AddtravelDetails(selectTravelType: "FROM",selectFrom: "Patna Junction",selectTo: "IIT Patna",selectModeoftravel: "Railways") );},iconimage: "trainicon.png",colornum: 1),
          destinationlistitems(destinationname: 'Patliputra Junction',Distance: "29",onTap: ()
          {print(traveltype+'Patliputra Junction');
          Navigator.pushNamed(context, ConfirmAddTravelScreen.id,arguments:AddtravelDetails(selectTravelType: "FROM",selectFrom: "Patliputra Junction",selectTo: "IIT Patna",selectModeoftravel: "Railways") );},iconimage: "trainicon.png",colornum: 0),
          destinationlistitems(destinationname: 'Rajendra Nagar Terminal',Distance: "39",onTap: ()
          {print(traveltype +'Rajendra Nagar Terminal');
          Navigator.pushNamed(context, ConfirmAddTravelScreen.id,arguments:AddtravelDetails(selectTravelType: "FROM",selectFrom: "Rajendranagar Terminal",selectTo: "IIT Patna",selectModeoftravel: "Railways") );},iconimage: "trainicon.png",colornum: 1),


        ],
      );
    }
}