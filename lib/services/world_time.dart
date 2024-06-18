import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'dart:convert';
import 'package:intl/intl.dart';

class WorldTime {

  String location; // location name for the ui
  String time = "";
  String flag; // url to an asset for the flag icon
  String url ; // location url for api endpoint
  bool isDayTime = true;

  WorldTime({required this.location, required this.flag, required this.url});

  Future<String> geTime() async{

    try {
      Response response = await get(Uri.parse("http://worldtimeapi.org/api/timezone/$url"));
      Map data = jsonDecode(response.body);

      //get properties for data
      String dateTime = data["datetime"];
      String offset = data["utc_offset"].substring(1,3);

      // create dateTime object

      DateTime now = DateTime.parse(dateTime);
      now = now.add(Duration(hours: int.parse(offset)));

      // set the time property
      isDayTime = now.hour > 6 && now.hour < 19 ? true : false;
      time = DateFormat.jm().format(now);
    } catch(e) {
      if (kDebugMode) {
        print('caught error: $e');
      }
      time = "could not get time";
    }

    return time;
  }
}

