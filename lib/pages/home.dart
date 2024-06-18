import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data  = data.isNotEmpty ? data : ModalRoute.of(context)?.settings.arguments as Map ;
    if (kDebugMode) {
      print(data);
    }
    // set background
    String bgImage = data["isDayTime"] ? 'day.png' : 'night.png';
    Color bgColor = data['isDayTime'] ? Colors.blue : Colors.indigo.shade800 ;

    return Scaffold(
      backgroundColor: bgColor,
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/$bgImage'),
              fit: BoxFit.cover
            )
          ),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(0,120,0,0),
            child: Column(
              children: [
                TextButton.icon(
                  onPressed: () async{
                    dynamic result = await Navigator.pushNamed(context, "/location");
                    setState(() {
                      data = {
                        'time': result["time"],
                        'location': result["location"],
                        'isDayTime': result["isDayTime"],
                        'flag': result["flag"],
                      };
                    });
                  },
                  icon: Icon(
                    Icons.location_on,
                    color: Colors.grey.shade400,
                  ),
                  label: Text("Edit location",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey.shade400,
                    ),
                  ),
                ),
                const SizedBox(height: 40,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(data['location'],
                      style: const TextStyle(
                        letterSpacing: 2,
                        color: Colors.white,
                        fontSize: 28,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    CircleAvatar(
                      backgroundImage: AssetImage("assets/${data["flag"]}"),
                    )
                  ],
                ),
                const SizedBox(height: 20,),
                Text(data['time'],
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 66
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
