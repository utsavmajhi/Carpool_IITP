import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:carpool/res/event_firestore_service.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:carpool/model/event.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:firebase_helpers/firebase_helpers.dart';
import 'package:url_launcher/url_launcher.dart';
import 'Dialog.dart';
class CalenderUI extends StatefulWidget {
  static String id='calender_screen';
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<CalenderUI> {
  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _events = {};
    _selectedEvents = [];
  }

  Map<DateTime, List<dynamic>> _groupEvents(List<EventModel> allEvents) {
    Map<DateTime, List<dynamic>> data = {};
    allEvents.forEach((event) {
      DateTime date = DateTime(
          event.eventDate.year, event.eventDate.month, event.eventDate.day, 12);
      if (data[date] == null) data[date] = [];
      data[date].add(event);
    });
    return data;
  }


  Stream<List<EventModel>> streamListCustom() {

    var ref = Firestore.instance.collection("events").orderBy("timeofj");
    return ref.snapshots().map((list) =>
        list.documents.map((doc) => eventDBS.fromDS(doc.documentID, doc.data)).toList());
  }
  @override
  Widget build(BuildContext context) {
    var size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      extendBodyBehindAppBar: true,

      body: StreamBuilder<List<EventModel>>(
          stream: streamListCustom(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List<EventModel> allEvents = snapshot.data;
              if (allEvents.isNotEmpty) {
                _events = _groupEvents(allEvents);
              } else {
                _events = {};
                _selectedEvents = [];
              }
            }
            return SingleChildScrollView(
              child: Column(
                children: <Widget>[
                  ClipPath(
                    clipper: MyClipper(),
                    child: Container(
                      height: size.height*.3,
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
                            child: Hero(
                              tag: 'CalenderHero',
                              child: CircleAvatar(
                                  radius: (38),
                                  backgroundColor: Colors.white,
                                  child: ClipRRect(
                                    borderRadius:BorderRadius.circular(20),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: SvgPicture.asset('images/calendar.svg'),
                                      ),
                                    ),
                                  )
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'Events Calendar',
                              style: GoogleFonts.raleway(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize: 30
                              ),
                            ),
                          ),
                        ],
                      ),

                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      TableCalendar(
                        events: _events,
                        initialCalendarFormat: CalendarFormat.week,
                        calendarStyle: CalendarStyle(
                            canEventMarkersOverflow: true,
                            todayColor: Colors.orange,
                            selectedColor: Theme.of(context).primaryColor,
                            todayStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white)),
                        headerStyle: HeaderStyle(
                          centerHeaderTitle: true,
                          formatButtonDecoration: BoxDecoration(
                            color: Colors.orange,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          formatButtonTextStyle: TextStyle(color: Colors.white),
                          formatButtonShowsNext: false,
                        ),
                        startingDayOfWeek: StartingDayOfWeek.monday,
                        onDaySelected: (date, events) {
                          setState(() {
                            _selectedEvents = events;
                          });
                        },
                        builders: CalendarBuilders(
                          selectedDayBuilder: (context, date, events) => Container(
                              margin: const EdgeInsets.all(4.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Theme.of(context).primaryColor,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(color: Colors.white),
                              )),
                          todayDayBuilder: (context, date, events) => Container(
                              margin: const EdgeInsets.all(4.0),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                  color: Colors.orange,
                                  borderRadius: BorderRadius.circular(10.0)),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(color: Colors.white),
                              )),
                        ),
                        calendarController: _controller,
                      ),
                      ..._selectedEvents.map((event) => Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: GestureDetector(
                          onTap: ()async{
                            //
                            final action =
                                await Dialogs.yesAbortDialog(context, 'Confirm', 'Do you want to call ${event.phn} ?');
                            if (action == DialogAction.yes) {
                              setState((){
                                launch(('tel://${event.phn}'));
                              });
                            } else {
                              setState((){
                                print("No");
                              });
                            }
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4),
                            ),

                            color: event.description=="TO"? Colors.orange[300]:Colors.blueAccent,
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(Icons.person_pin,color: event.description=="TO"?Colors.black:Colors.white),
                                          Container(
                                            width: 100,
                                            child: Text(
                                              event.creatorname,
                                              style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.w700,
                                                color: event.description=="TO"?Colors.black:Colors.white,
                                              ),

                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          Icon(Icons.call,color: event.description=="TO"?Colors.black:Colors.white),
                                          Text(
                                              event.phn,
                                            style: TextStyle(

                                                fontWeight: FontWeight.w700,
                                                fontSize: 16,
                                              color: event.description=="TO"?Colors.black:Colors.white,
                                            ),
                                          ),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            '#  people:',
                                            style: TextStyle(

                                                fontWeight: FontWeight.w700,
                                              color: event.description=="TO"?Colors.black:Colors.white,

                                            ),
                                          ),
                                          Text(
                                            event.nofpeople,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w700,
                                              color: event.description=="TO"?Colors.black:Colors.white,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Text('FROM', style: TextStyle(fontWeight: FontWeight.bold, decoration: TextDecoration.underline,color: event.description=="TO"?Colors.black:Colors.white,),),
                                        ],
                                      ),
                                      Row(
                                        children: <Widget>[
                                          event.description=="TO"?Icon(Icons.school,color: event.description=="TO"?Colors.black:Colors.white):event.modeofj=="Railways"?Icon(Icons.train,color: event.description=="TO"?Colors.black:Colors.white):Icon(Icons.flight,color: event.description=="TO"?Colors.black:Colors.white),
                                          Text(event.placefrom, style: TextStyle(fontSize: 14,fontWeight: FontWeight.w700,color: event.description=="TO"?Colors.black:Colors.white),),
                                        ],
                                      ),
                                      Text(
                                        'TO',
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: event.description=="TO"?Colors.black:Colors.white,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                      Row(
                                        children: <Widget>[
                                          event.description=="TO"?event.modeofj=="Railways"?Icon(Icons.train,color: event.description=="TO"?Colors.black:Colors.white):Icon(Icons.flight,color: event.description=="TO"?Colors.black:Colors.white):Icon(Icons.school,color: event.description=="TO"?Colors.black:Colors.white),
                                          Text(
                                            event.placeto,
                                            style: TextStyle(
                                                fontSize: 14,fontWeight: FontWeight.w700,
                                              color: event.description=="TO"?Colors.black:Colors.white,
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: <Widget>[
                                      Row(
                                        children: <Widget>[
                                          Icon(Icons.timelapse,color: event.description=="TO"?Colors.black:Colors.white),
                                          event.description=="TO"? Text('Departure', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: event.description=="TO"?Colors.black:Colors.white,),):Text('Arrival', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: event.description=="TO"?Colors.black:Colors.white,),),
                                        ],
                                      ),

                                      Text(
                                        changetimeformat(event.timeofj),
                                        style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: event.description=="TO"?Colors.black:Colors.white,
                                        ),
                                      ),

                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      )),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

}



changetimeformat(@required DateTime datetimepicked)
{
  String formattedDate = DateFormat('HH:mm').format(datetimepicked);

  return formattedDate;

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
