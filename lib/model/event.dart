import 'package:firebase_helpers/firebase_helpers.dart';

class EventModel extends DatabaseItem{
  final String id;
  final String title;
  final String description;
  final DateTime eventDate;

  final String placefrom;
  final String placeto;
  final String modeofj;
  final String timeofj;
  final String phn;
  final String nofpeople;
  final String creatoruid;
  final String creatorname;


  EventModel({this.id,this.title, this.description, this.eventDate,this.placefrom,this.placeto,this.modeofj,this.timeofj,this.phn,this.nofpeople,this.creatoruid,this.creatorname}):super(id);

  factory EventModel.fromMap(Map data) {
    return EventModel(
      title: data['title'],
      description: data['description'],
      eventDate: data['event_date'],

      placefrom: data['placefrom'],
      placeto: data['placeto'],
      modeofj: data['modeofj'],
      timeofj: data['timeofj'],
      phn: data['phone'],
      nofpeople: data['nofpeople'],
      creatoruid: data['creatoruid'],
      creatorname: data['creatorname'],
    );
  }

  factory EventModel.fromDS(String id, Map<String,dynamic> data) {
    return EventModel(
      id: id,
      title: data['title'],
      description: data['description'],
      eventDate: data['event_date'].toDate(),

      placefrom: data['placefrom'],
      placeto: data['placeto'],
      modeofj: data['modeofj'],
      timeofj: data['timeofj'],
      phn: data['phone'],
      nofpeople: data['nofpeople'],
      creatoruid: data['creatoruid'],
      creatorname: data['creatorname']
    );
  }

  Map<String,dynamic> toMap() {
    return {
      "title":title,
      "description": description,
      "event_date":eventDate,
      "id":id,

      "placefrom":placefrom,
      "placeto":placeto,
      "modeofj":modeofj,
      "timeofj": timeofj,
      "phn":phn,
      "nofpeople": nofpeople,
      "creatoruid":creatoruid,
      "creatorname" :creatorname,
    };
  }
}