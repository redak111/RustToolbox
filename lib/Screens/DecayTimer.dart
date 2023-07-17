import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_timezone/flutter_native_timezone.dart';
import 'package:rusttoolbox/Utils/ReadData.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import 'CameraFreq.dart';
import 'MainMenu.dart';
import 'RaidCalculator.dart';
import 'Settings.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  final String currentTimeZone = await FlutterNativeTimezone.getLocalTimezone();
  tz.setLocalLocation(tz.getLocation(currentTimeZone));
}

int currentId = 0;
var Items = GetStructItems();
int Delay = 0;

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

double calcTimeInHours(String currentHpS, String tickRateS) {
  try {
    double CurrentHp = double.parse(currentHpS);
    double TickRate = double.parse(tickRateS);
    double HPDecreasePerCycle = (Items[currentId]["health"] as int) /
        ((Items[currentId]["decayTime"] as int) * 60);
    double EstimatedTimeInHours =
        ((CurrentHp / HPDecreasePerCycle) * TickRate) / 60 / 60 / 5;
    double floored = double.parse(EstimatedTimeInHours.toStringAsFixed(2));
    return floored;
  } catch (e) {
    return -1;
  }
}

String convertToTimeString(double time) {
  if (time != -1) {
    int hours = time.floor();
    double minD = ((time * 60) - (time.floor() * 60));
    double secD = ((minD - minD.floor()) * 60);
    int min = minD.floor();
    int sec = secD.floor();
    return "$hours h  $min m  $sec s";
  }
  return "0 h  0 m  0 s";
}

Duration convertToTime(double time) {
  int hours = time.floor();
  double minD = ((time * 60) - (time.floor() * 60));
  double secD = ((minD - minD.floor()) * 60);
  int min = minD.floor();
  int sec = secD.floor();

  return Duration(hours: hours, minutes: min, seconds: sec);
}

String _pad2(int i) => i.toString().padLeft(2, '0');

String convertToBTime(DateTime time) {
  int days = time.day;
  int months = time.month;
  int year = time.year;
  int min = time.minute;
  int hour = time.hour;
  int sec = time.second;

  return "$year/$months/$days  ${_pad2(hour)}:${_pad2(min)}:${_pad2(sec)}";
}

class DecayTimer extends StatefulWidget {
  const DecayTimer({super.key});

  @override
  State<DecayTimer> createState() => _DecayTimer();
}

class _DecayTimer extends State<DecayTimer> {
  void onDidReceiveNotificationResponse(
      NotificationResponse notificationResponse) async {
    final String? payload = notificationResponse.payload;
    if (notificationResponse.payload != null) {
      debugPrint('notification payload: $payload');
    }
  }

  @override
  void initState() {
    super.initState();
    _getNotifySetting();
    var initializationSettingsAndroid = const AndroidInitializationSettings(
        '@mipmap/ic_launcher'); // <- default icon name is @mipmap/ic_launcher
    var initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onDidReceiveNotificationResponse: onDidReceiveNotificationResponse);
    _isAndroidPermissionGranted();
    _requestPermissions();
  }

  Future<void> _isAndroidPermissionGranted() async {
    await flutterLocalNotificationsPlugin
            .resolvePlatformSpecificImplementation<
                AndroidFlutterLocalNotificationsPlugin>()
            ?.areNotificationsEnabled() ??
        false;
  }

  Future<void> _requestPermissions() async {
    final AndroidFlutterLocalNotificationsPlugin? androidImplementation =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    await androidImplementation?.requestPermission();
  }

  int id = 1;

  Future<void> _getNotifySetting() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      Delay = (prefs.getInt('notificationDelay') ?? 0);
    });
  }

  Future<void> _showFutureNotification(
      String title, String body, Duration time, int id) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.now(tz.local).add(time),
        const NotificationDetails(
            android: AndroidNotificationDetails('123', '123',
                channelDescription: '123')),
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Timer? timer;

  Map _currentItem = Items[currentId];
  var _estimatedTime = "0 h  0 m  0 s";
  final _listOfNotifies = <Widget>[];
  final _infoList = [];
  final _timeList = [];
  final _idInfoList = [];

  Container createNewContainer(BuildContext context, String estTime,
      String location, String type, String index) {
    Container nC = Container(
      margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
      padding: const EdgeInsets.all(0),
      width: MediaQuery.of(context).size.width * 0.9,
      height: 85,
      decoration: BoxDecoration(
        color: const Color(0x4c1e201f),
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(5.0),
        border: Border.all(color: const Color(0x4d9e9e9e), width: 1),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.max,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 3, 2, 0),
            child: Align(
              alignment: Alignment.topRight,
              child: MaterialButton(
                onPressed: () {
                  setState(() {
                    int inD = _infoList.indexOf(index);
                    flutterLocalNotificationsPlugin
                        .cancel(_idInfoList[_infoList.indexOf(index)]);
                    _infoList.removeAt(inD);
                    _idInfoList.removeAt(inD);
                    _timeList.removeAt(inD);
                    _listOfNotifies.removeAt(inD);
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                color: const Color(0x00ffffff),
                elevation: 0,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.zero,
                ),
                padding: const EdgeInsets.fromLTRB(3, 0, 3, 0),
                textColor: const Color(0xbe8c8c8c),
                height: MediaQuery.of(context).size.height * 0.01,
                minWidth: MediaQuery.of(context).size.width * 0.01,
                child: const Text(
                  "X",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Est Time: ${_timeList[_infoList.indexOf(index)]}",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xbf8c8c8c),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 2, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Location: $location",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xbe8c8c8c),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(34, 2, 0, 0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Type: $Type",
                textAlign: TextAlign.start,
                overflow: TextOverflow.clip,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.normal,
                  fontSize: 14,
                  color: Color(0xbe8c8c8c),
                ),
              ),
            ),
          ),
        ],
      ),
    );
    return nC;
  }

  TextEditingController cHPController = TextEditingController();
  TextEditingController locationController = TextEditingController();
  TextEditingController tickRateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _configureLocalTimeZone();
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xff232728),
        appBar: AppBar(
          elevation: 4,
          centerTitle: true,
          backgroundColor: const Color(0xff2f3130),
          title: const Text(
            "Decay Timer",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 14,
              color: Color(0xbea5a6a7),
            ),
          ),
          iconTheme: const IconThemeData(color: Color(0xbfa5a6a7)),
          actions: [
            IconButton(
              icon: const Icon(
                Icons.settings,
                color: Color(0xbea5a6a7),
                size: 24,
              ),
              onPressed: () => {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SettingsMenu()),
                )
              },
            ),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  padding: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.15,
                  decoration: BoxDecoration(
                    color: const Color(0xff2f3130),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    border:
                        Border.all(color: const Color(0xb23f4241), width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.fromLTRB(15, 0, w * 0.17, 0),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            if (currentId == 0) {
                              currentId = Items.length - 1;
                            } else {
                              currentId -= 1;
                            }
                            setState(() {
                              _currentItem = Items[currentId];
                              var estimatedTime = calcTimeInHours(
                                  cHPController.text, tickRateController.text);
                              _estimatedTime =
                                  convertToTimeString(estimatedTime);
                            });
                          },
                          color: const Color(0xbfa5a6a7),
                          iconSize: 24,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(0, 0, w * 0.16, 0),
                        child: Image(
                          image:
                              AssetImage((_currentItem["iconPath"] as String)),
                          height: 80,
                          width: 80,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            if (currentId == Items.length - 1) {
                              currentId = 0;
                            } else {
                              currentId += 1;
                            }
                            setState(() {
                              _currentItem = Items[currentId];
                              var estimatedTime = calcTimeInHours(
                                  cHPController.text, tickRateController.text);
                              _estimatedTime =
                                  convertToTimeString(estimatedTime);
                            });
                          },
                          color: const Color(0xbda5a6a7),
                          iconSize: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                  color: const Color(0xff2f3130),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: const Color(0xb23f4241), width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Current HP",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xbe8c8c8c),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 7, 10, 0),
                      child: TextField(
                        controller: cHPController,
                        onChanged: (text) {
                          setState(() {
                            var estimatedTime = calcTimeInHours(
                                cHPController.text, tickRateController.text);
                            _estimatedTime = convertToTimeString(estimatedTime);
                          });
                        },
                        obscureText: false,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0x7fa5a6a7),
                        ),
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                                color: Color(0x661e201f), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                                color: Color(0x661e201f), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                                color: Color(0x661e201f), width: 1),
                          ),
                          filled: true,
                          fillColor: const Color(0x4c1e201f),
                          hintText: "(Example: 1000)",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x23a5a6a7),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  padding: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                    color: const Color(0xff2f3130),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    border:
                        Border.all(color: const Color(0xff3f4241), width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Location",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0xbe8c8c8c),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 7, 10, 0),
                        child: TextField(
                          controller: locationController,
                          onChanged: (text) {
                            setState(() {
                              var estimatedTime = calcTimeInHours(
                                  cHPController.text, tickRateController.text);
                              _estimatedTime =
                                  convertToTimeString(estimatedTime);
                            });
                          },
                          obscureText: false,
                          textAlign: TextAlign.start,
                          maxLines: 1,
                          style: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x80a5a6a7),
                          ),
                          decoration: InputDecoration(
                            disabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  color: Color(0x671e201f), width: 1),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  color: Color(0x671e201f), width: 1),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(5.0),
                              borderSide: const BorderSide(
                                  color: Color(0x671e201f), width: 1),
                            ),
                            hintText: "(Example: C12)",
                            hintStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontStyle: FontStyle.normal,
                              fontSize: 14,
                              color: Color(0x23a5a6a7),
                            ),
                            filled: true,
                            fillColor: const Color(0x4c1e201f),
                            isDense: true,
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 13, horizontal: 12),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.12,
                decoration: BoxDecoration(
                  color: const Color(0xff2f3130),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: const Color(0xff3f4241), width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Decay TickRate (Default 300)",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xbe8c8c8c),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 7, 10, 0),
                      child: TextField(
                        controller: tickRateController,
                        onChanged: (text) {
                          setState(() {
                            var estimatedTime = calcTimeInHours(
                                cHPController.text, tickRateController.text);
                            _estimatedTime = convertToTimeString(estimatedTime);
                          });
                        },
                        obscureText: false,
                        textAlign: TextAlign.start,
                        maxLines: 1,
                        style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0x80a5a6a7),
                        ),
                        decoration: InputDecoration(
                          disabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                                color: Color(0x651e201f), width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                                color: Color(0x651e201f), width: 1),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                            borderSide: const BorderSide(
                                color: Color(0x651e201f), width: 1),
                          ),
                          filled: true,
                          fillColor: const Color(0x4d1e201f),
                          hintText: "(Default: 300)",
                          hintStyle: const TextStyle(
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x23a5a6a7),
                          ),
                          isDense: true,
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 13, horizontal: 12),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.13,
                decoration: BoxDecoration(
                  color: const Color(0xff2f3130),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: const Color(0xff3f4241), width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 6, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Estimated Time: $_estimatedTime",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xbe8c8c8c),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      child: MaterialButton(
                        onPressed: () async {
                          var estimatedTime = calcTimeInHours(
                              cHPController.text, tickRateController.text);
                          if (estimatedTime != -1 &&
                              locationController.text != "") {
                            var nEstimatedTime =
                                convertToTimeString(estimatedTime);
                            String ranString = getRandomString(10);
                            var existingItem = _infoList.firstWhere(
                                (itemToCheck) => itemToCheck == (ranString),
                                orElse: () => null);
                            if (existingItem == null) {
                              Duration time = convertToTime(estimatedTime);
                              if (time.inSeconds > (Delay * 60)) {
                                time -= Duration(minutes: Delay);
                              }
                              id++;
                              await _showFutureNotification(
                                  "Decay Timer",
                                  "${_currentItem["name"]} decayed at location ${locationController.text}",
                                  time,
                                  id);
                              final now = DateTime.now();
                              setState(() {
                                _infoList.add(ranString);
                                _idInfoList.add(id);
                                _timeList.add(convertToBTime(now.add(time)));
                                _listOfNotifies.add(createNewContainer(
                                    context,
                                    nEstimatedTime,
                                    locationController.text,
                                    (_currentItem["name"] as String),
                                    ranString));
                              });
                            }
                          }
                        },
                        color: const Color(0x4c1e201f),
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5.0),
                          side: const BorderSide(
                              color: Color(0x661e201f), width: 1),
                        ),
                        padding: const EdgeInsets.all(16),
                        textColor: const Color(0x7fa5a6a7),
                        height: 40,
                        minWidth: 140,
                        child: const Text(
                          "Notify Me!",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 0),
                padding: const EdgeInsets.all(0),
                width: MediaQuery.of(context).size.width * 0.9,
                height: MediaQuery.of(context).size.height * 0.5,
                decoration: BoxDecoration(
                  color: const Color(0xff2f3130),
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(10.0),
                  border: Border.all(color: const Color(0xff3f4241), width: 1),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    const Padding(
                      padding: EdgeInsets.fromLTRB(10, 6, 0, 0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Decaying locations",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xbe8c8c8c),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 5, 0, 0),
                        child: SingleChildScrollView(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: _listOfNotifies,
                          ),
                        ),
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
        drawer: Drawer(
          backgroundColor: const Color(0xff2f3130),
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              Container(
                padding: EdgeInsets.fromLTRB(w * 0.08, h * 0.06, 0, h * 0.02),
                color: const Color.fromARGB(255, 54, 54, 54),
                child: Row(
                  children: [
                    Container(
                      height: h * 0.08,
                      width: h * 0.08,
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      child: Image.asset("images/Icon.png", fit: BoxFit.cover),
                    ),
                    Padding(
                      padding: EdgeInsets.fromLTRB(w * 0.05, 0, 0, 0),
                      child: const Text(
                        'Rust Toolbox',
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: 20,
                          color: Color(0xbea5a6a7),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              ListTile(
                title: const Text('Home'),
                textColor: const Color(0xbea5a6a7),
                leading: const Icon(
                  Icons.house_rounded,
                  color: Color(0xbea5a6a7),
                  size: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const MainMenu()),
                  );
                },
              ),
              ListTile(
                title: const Text('Decay Timer'),
                textColor: const Color(0xbea5a6a7),
                leading: const Icon(
                  Icons.access_time_rounded,
                  color: Color(0xbea5a6a7),
                  size: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const DecayTimer()),
                  );
                },
              ),
              ListTile(
                title: const Text('Raid Calculator'),
                textColor: const Color(0xbea5a6a7),
                leading: const Icon(
                  Icons.rocket_launch_rounded,
                  color: Color(0xbea5a6a7),
                  size: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const RaidCalculator()),
                  );
                },
              ),
              ListTile(
                title: const Text('Cameras & Frequencies'),
                textColor: const Color(0xbea5a6a7),
                leading: const Icon(
                  Icons.camera_alt_rounded,
                  color: Color(0xbea5a6a7),
                  size: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const CamerasFreq()),
                  );
                },
              ),
              ListTile(
                title: const Text('Settings'),
                textColor: const Color(0xbea5a6a7),
                leading: const Icon(
                  Icons.settings,
                  color: Color(0xbea5a6a7),
                  size: 24,
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsMenu()),
                  );
                },
              ),
              Padding(
                  padding: EdgeInsets.fromLTRB(0, h * 0.415, 10, 0),
                  child: const Align(
                    alignment: Alignment.bottomRight,
                    child: Text(
                      "v. 0.01",
                      textAlign: TextAlign.start,
                      overflow: TextOverflow.clip,
                      style: TextStyle(
                        fontWeight: FontWeight.w300,
                        fontStyle: FontStyle.normal,
                        fontSize: 12,
                        color: Color(0xc18c8c8c),
                      ),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
