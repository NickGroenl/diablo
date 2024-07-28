
// ignore_for_file: curly_braces_in_flow_control_structures

import 'dart:async';

import 'package:diablo/hooks/api_hook.dart';
import 'package:diablo/hooks/notifications.hook.dart';
import 'package:alarmplayer/alarmplayer.dart';
import 'package:diablo/models/zones.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
void startBackgroundService() {
  final service = FlutterBackgroundService();
  service.startService();
  FinderEventsManager.start();
}

void stopBackgroundService() {
  final service = FlutterBackgroundService();
  service.invoke("stop");
  
}
class FinderEventsManager {
  static Future<void> _oneShotAtTaskCallback() async {
    if(botState.value == 1){
      DateTime time = DateTime.now();
      if(time.minute < 7 && time.minute > 4){
        showNotification('Aviso', "Se habilitaron nuevas zonas");
      } else {
          bool finded = false;
          String titles = 'No encontrado';
          for(var e=0; e<nextZones.value.length;e++){
            if(titles == 'No encontrado'){
              titles = currentZones.value.firstWhere((a) => a.code == nextZones.value[e] && a.state == 'true', orElse: () => ZoneModel()).title;
            }
          }
          if(titles != 'No encontrado'){
            finded = true;
          }
          if(finded){
                showNotification('Recordatorio', "Pronto se habilitan nuevas zonas ");
                Alarmplayer alarmplayer = Alarmplayer();

                await alarmplayer.Alarm(
                  url: "assets/sound.mp3",  // Path of sound file. 
                  looping: true,             // optional, if you want to loop you're alarm or not
                  callback: ()              // this is the callback, it's getting executed if you're alarm
                  => {print("i'm done!")}   // is done playing. Note if you're alarm is on loop you're callback won't be executed 
              );
          }
      }
      fethZones();
      FinderEventsManager.start();
    }
  }
  static Future<void> start() async {
    if(botState.value == 1){ 
      DateTime time = DateTime.now();
      Duration duration;
      if(time.minute < currentTime.value){
        duration = Duration(minutes: (currentTime.value - time.minute));
      } else {
        duration = Duration(minutes: (60 - time.minute) + 5);
      }
      Future.delayed(duration, _oneShotAtTaskCallback);

    }
  }
  
  
}
