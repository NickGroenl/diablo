
// ignore_for_file: prefer_const_constructors
import 'dart:convert';

import 'package:diablo/hooks/api_hook.dart';
import 'package:diablo/hooks/events_hook.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
import 'package:diablo/main.dart';
import 'package:diablo/models/zones.dart';
import 'package:flutter/material.dart';
import 'package:alarmplayer/alarmplayer.dart';

Future<void> saveZoneStates (String zoness) async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  sharedPref.setString('zones', zoness);//storing
}
Future<void> loadZoneStates () async {
  SharedPreferences sharedPref = await SharedPreferences.getInstance();
  String decodes = sharedPref.getString('zones') ?? '';
  if(decodes.isNotEmpty){
    List<dynamic> zonesMap = jsonDecode(decodes); //retriving
    var zoness = zonesMap.map((e) => ZoneModel.fromJSON(e)).toList();
    if(zones.isNotEmpty){
      currentZones.value = zoness;
    }
  }
  
}
class Home extends StatefulWidget {
  const Home({super.key});

  @override
  createState() => _Home();
}

class _Home extends State<Home> {
  late bool timeState = false;
  @override
  void initState() {
    super.initState();    
    loadZoneStates();
    fethZones();
  }
  Future<void> stopaalarm() async {
    Alarmplayer alarmplayer = Alarmplayer();
    if(await alarmplayer.IsPlaying()){
      alarmplayer.StopAlarm();
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            ///
            /// Header image slider
            ///
            SafeArea(child: SizedBox()),
            SizedBox(height: 20,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
              "Actual",
                        style: TextStyle(
                          fontSize: 20.0,
                          height: 1.5,
                          color: Color.fromARGB(255, 178, 179, 182),
                          fontWeight: FontWeight.w600,
                        ),
            )),
            ValueListenableBuilder(valueListenable: nowZones, 
            builder: (BuildContext context, value, Widget? child) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    String titles = currentZones.value.firstWhere((a) => a.code == value[index], orElse: ()=> ZoneModel())!.title;
                     
                    return titles == 'No encontrado' ? SizedBox() : ListTile(
                      onTap: () {
                        
                      },
                      title: Text(titles ),
                    );
                  },
                );
            }),
            SizedBox(height: 16,),
            Padding(padding: EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
              "Proximo ",
                        style: TextStyle(
                          fontSize: 20.0,
                          height: 1.5,
                          color: Color.fromARGB(255, 178, 179, 182),
                          fontWeight: FontWeight.w600,
                        ),
            )),
            
          ValueListenableBuilder(valueListenable: nextZones, 
            builder: (BuildContext context, value, Widget? child) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    String titles = currentZones.value.firstWhere((a) => a.code == value[index] , orElse: () => ZoneModel()).title;
                    return titles == 'No encontrado' ? SizedBox(width: 0, height: 0) : ListTile(
                      onTap: () {
                        
                      },
                      title: Text(titles),
                      
                    );
                  },
                );
            }),
            SizedBox(height: 25,),
            Center(child: ElevatedButton(onPressed: botState.value == 1 ? (() => {
              botState.value = 0,
              setState(() {}),
              stopBackgroundService(),


              }) : (() => {
              
              botState.value = 1,
              setState(() {}),
              startBackgroundService(),

              }), child: Text(botState.value == 1 ? 'STOP' : 'RUN')),),
            SizedBox(height: 5,),
            Center(child: TextButton(onPressed: () async {await stopaalarm();}, child: Text('Stop Sound')),),
            SizedBox(height: 16,),
            Padding(padding: EdgeInsets.all(15.0),
              child: Text(
              "Recordatorios",
                        style: TextStyle(
                          fontSize: 20.0,
                          height: 1.5,
                          color: Color.fromARGB(255, 178, 179, 182),
                          fontWeight: FontWeight.w600,
                        ),
            )),
            ListTile(
              onTap: () {
                        
              },
              title: Text('XX:35', style: const TextStyle(color: Color.fromARGB(255, 178, 179, 182),)),
              trailing: ElevatedButton(child: Icon(currentTime.value == 35 ? Icons.check : Icons.cancel, color: currentTime.value == 35 ? Color.fromARGB(255, 172, 97, 143) : Color.fromARGB(255, 153, 152, 153)), onPressed: () {
                currentTime.value = 35;
                setState(() {});
              },),
            ),
            ListTile(
              onTap: () {
                        
              },
              title: Text('XX:55', style: const TextStyle(color: Color.fromARGB(255, 178, 179, 182),)),
              trailing: ElevatedButton(child: Icon(currentTime.value == 55 ? Icons.check : Icons.cancel, color: currentTime.value == 55 ? Color.fromARGB(255, 172, 97, 143) : Color.fromARGB(255, 153, 152, 153)), onPressed: () {
                currentTime.value = 55;
                setState(() {});
              },),
            ),
            SizedBox(height: 16,),
            Padding(padding: EdgeInsets.all(15.0),
              child: Text(
              "Zonas",
                        style: TextStyle(
                          fontSize: 20.0,
                          height: 1.5,
                          color: Color.fromARGB(255, 178, 179, 182),
                          fontWeight: FontWeight.w600,
                        ),
            )),
        
            ValueListenableBuilder(valueListenable: currentZones, 
            builder: (BuildContext context, value, Widget? child) {
                return ListView.builder(
                  shrinkWrap: true,
                  physics: const BouncingScrollPhysics(),
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    Color colorr = value[index].state == 'true' ? Color.fromARGB(255, 172, 97, 143) : Color.fromARGB(255, 153, 152, 153);
                    IconData iconss = value[index].state == 'true' ? Icons.check : Icons.cancel;
                    return ListTile(
                      onTap: () {
                        
                      },
                      leading: const CircleAvatar(backgroundColor: Color.fromARGB(255, 179, 166, 179),),
                      title: Text(value[index].title, style: const TextStyle(color: Color.fromARGB(255, 178, 179, 182),)),
                      trailing: ElevatedButton(child: Icon(iconss, color: colorr), onPressed: () {
                        dynamic castValue = value;
                        castValue[index].state = castValue[index].state == 'true' ? 'false' : 'true';
                        currentZones.value = castValue;
                        saveZoneStates(json.encode(castValue));
                        setState(() {});
                      },),
                    );
                  },
                );
            })
          ],
        ),
      ),
    );
  }

 

}