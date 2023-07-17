import 'dart:math';

import 'package:flutter/material.dart';
import 'package:rusttoolbox/Utils/ReadData.dart';

import 'CameraFreq.dart';
import 'DecayTimer.dart';
import 'MainMenu.dart';
import 'Settings.dart';

const _chars = 'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
Random _rnd = Random();

String getRandomString(int length) => String.fromCharCodes(Iterable.generate(
    length, (_) => _chars.codeUnitAt(_rnd.nextInt(_chars.length))));

var StructItems = GetStructItems();
var RaidItems = GetRaidItems();
var Modes = ["Damaged"];

int currentId_Mode = 0;
int currentId_Item = 0;
int currentId_Raid = 0;

class RaidCalculator extends StatefulWidget {
  const RaidCalculator({super.key});

  @override
  State<RaidCalculator> createState() => _RaidCalculator();
}

class _RaidCalculator extends State<RaidCalculator> {
  TextEditingController cHPController = TextEditingController();
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  String _currentMode = Modes[currentId_Mode];
  Map _currentItem = StructItems[currentId_Item];
  Map _currentRaid = RaidItems[currentId_Raid];

  final _listOfRaid = <Widget>[];
  final _infoList = [];
  final _spInfoList = [];

  int _sulfurEstimate = 0;
  double _healthEstimate = 0;

  void calculateEverything() {
    num currNeededSulfur = 0;
    num currHP = double.tryParse(cHPController.text) ?? 0.0;
    for (var item in _spInfoList) {
      currNeededSulfur += item["currentNumber"] * item["item"]["sulfur"];
      currHP -= ((item["item"][_currentItem["id"]]) *
          item["currentNumber"]);
    }

    if (currHP <= 0) {
      currHP = 0;
    }

    _sulfurEstimate = currNeededSulfur as int;
    _healthEstimate = double.parse(currHP.toStringAsFixed(2));
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    Container createNewContainer(
        BuildContext context, String index, String imagePath) {
      Container nC = Container(
        margin: const EdgeInsets.fromLTRB(0, 10, 10, 0),
        padding: const EdgeInsets.all(0),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.45,
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
                      _infoList.removeAt(inD);
                      _spInfoList.removeAt(inD);
                      _listOfRaid.removeAt(inD);
                      calculateEverything();
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
              padding: EdgeInsets.fromLTRB(w * 0, 0, 0, 5),
              child: Image(
                image: AssetImage(imagePath),
                height: 80,
                width: 80,
                fit: BoxFit.cover,
              ),
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.fromLTRB(w * 0.25, 0, 10, 0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios),
                    onPressed: () {
                      setState(() {
                        int inD = _infoList.indexOf(index);
                        if (1 < _spInfoList[inD]["currentNumber"]) {
                          _spInfoList[inD]["currentNumber"] =
                              _spInfoList[inD]["currentNumber"] - 1;
                        }
                        _counter.value = _spInfoList[inD]["currentNumber"];
                        calculateEverything();
                      });
                    },
                    color: const Color(0xbfa5a6a7),
                    iconSize: 24,
                  ),
                ),
                ValueListenableBuilder<int>(
                  builder: (BuildContext context, int value, Widget? child) {
                    return Align(
                      alignment: Alignment.center,
                      child: Text(
                        "${_spInfoList[_infoList.indexOf(index)]["currentNumber"]} x",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.clip,
                        style: const TextStyle(
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.normal,
                          fontSize: 14,
                          color: Color(0xbe8c8c8c),
                        ),
                      ),
                    );
                  },
                  valueListenable: _counter,
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 0, 0),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_forward_ios),
                    onPressed: () {
                      setState(() {
                        int inD = _infoList.indexOf(index);
                        _spInfoList[inD]["currentNumber"] =
                            _spInfoList[inD]["currentNumber"] + 1;
                        _counter.value = _spInfoList[inD]["currentNumber"];
                        calculateEverything();
                      });
                    },
                    color: const Color(0xbda5a6a7),
                    iconSize: 24,
                  ),
                ),
              ],
            ),
          ],
        ),
      );
      return nC;
    }

    return MaterialApp(
      home: Scaffold(
        backgroundColor: const Color(0xff232728),
        appBar: AppBar(
          elevation: 4,
          centerTitle: true,
          backgroundColor: const Color(0xff2f3130),
          title: const Text(
            "Raid Calculator",
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
            children: [
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  padding: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.08,
                  decoration: BoxDecoration(
                    color: const Color(0xff2f3130),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: const Color(0xb33f4241), width: 1),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          onPressed: () {
                            if (currentId_Mode == 0) {
                              currentId_Mode = Modes.length - 1;
                            } else {
                              currentId_Mode -= 1;
                            }
                            setState(() {
                              _currentMode = Modes[currentId_Mode];
                            });
                          },
                          color: const Color(0x80a5a6a7),
                          iconSize: 22,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.21, 0, 0, 0),
                        child: Text(
                          _currentMode,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xc08c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.21, 0, 0, 0),
                        child: IconButton(
                          icon: const Icon(Icons.arrow_forward_ios),
                          onPressed: () {
                            if (currentId_Mode == Modes.length - 1) {
                              currentId_Mode = 0;
                            } else {
                              currentId_Mode += 1;
                            }
                            setState(() {
                              _currentMode = Modes[currentId];
                            });
                          },
                          color: const Color(0x7ea5a6a7),
                          iconSize: 22,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Visibility(
                visible: true,
                child: Column(
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
                          border: Border.all(
                              color: const Color(0xb23f4241), width: 1),
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
                                  if (currentId_Item == 0) {
                                    currentId_Item = StructItems.length - 1;
                                  } else {
                                    currentId_Item -= 1;
                                  }
                                  setState(() {
                                    _currentItem = StructItems[currentId_Item];
                                  });
                                  calculateEverything();
                                },
                                color: const Color(0xbfa5a6a7),
                                iconSize: 24,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.fromLTRB(0, 0, w * 0.16, 0),
                              child: Image(
                                image: AssetImage(
                                    (_currentItem["iconPath"] as String)),
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
                                  if (currentId_Item ==
                                      StructItems.length - 1) {
                                    currentId_Item = 0;
                                  } else {
                                    currentId_Item += 1;
                                  }
                                  setState(() {
                                    _currentItem = StructItems[currentId_Item];
                                  });
                                  calculateEverything();
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
                        border: Border.all(
                            color: const Color(0xb23f4241), width: 1),
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
                                calculateEverything();
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
                          margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                          padding: const EdgeInsets.all(0),
                          width: MediaQuery.of(context).size.width * 0.9,
                          height: MediaQuery.of(context).size.height * 0.20,
                          decoration: BoxDecoration(
                            color: const Color(0xff2f3130),
                            shape: BoxShape.rectangle,
                            borderRadius: BorderRadius.circular(10.0),
                            border: Border.all(
                                color: const Color(0xb23f4241), width: 1),
                          ),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(15, 0, w * 0.17, 0),
                                    child: IconButton(
                                      icon: const Icon(Icons.arrow_back_ios),
                                      onPressed: () {
                                        if (currentId_Raid == 0) {
                                          currentId_Raid = RaidItems.length - 1;
                                        } else {
                                          currentId_Raid -= 1;
                                        }
                                        setState(() {
                                          _currentRaid =
                                              RaidItems[currentId_Raid];
                                        });
                                      },
                                      color: const Color(0xbfa5a6a7),
                                      iconSize: 24,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        EdgeInsets.fromLTRB(0, 0, w * 0.16, 5),
                                    child: Image(
                                      image: AssetImage(
                                          (_currentRaid["iconPath"] as String)),
                                      height: 80,
                                      width: 80,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 0, 0, 0),
                                    child: IconButton(
                                      icon: const Icon(Icons.arrow_forward_ios),
                                      onPressed: () {
                                        if (currentId_Raid ==
                                            RaidItems.length - 1) {
                                          currentId_Raid = 0;
                                        } else {
                                          currentId_Raid += 1;
                                        }
                                        setState(() {
                                          _currentRaid =
                                              RaidItems[currentId_Raid];
                                        });
                                      },
                                      color: const Color(0xbda5a6a7),
                                      iconSize: 24,
                                    ),
                                  ),
                                ],
                              ),
                              MaterialButton(
                                onPressed: () {
                                  setState(() {
                                    String ranString = getRandomString(10);
                                    var existingItem = _infoList.firstWhere(
                                        (itemToCheck) =>
                                            itemToCheck == (ranString),
                                        orElse: () => null);
                                    if (existingItem == null) {
                                      var newList = {
                                        "currentNumber": 1,
                                        "item": _currentRaid,
                                      };

                                      _infoList.add(ranString);
                                      _spInfoList.add(newList);
                                      _listOfRaid.add(createNewContainer(
                                          context,
                                          ranString,
                                          _currentRaid["iconPath"]));
                                      calculateEverything();
                                    }
                                  });
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
                                  "Add to raid",
                                  style: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    fontStyle: FontStyle.normal,
                                  ),
                                ),
                              ),
                            ],
                          )),
                    ),
                    Container(
                      margin: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.075,
                      decoration: BoxDecoration(
                        color: const Color(0xff2f3130),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: const Color(0xb23f4241), width: 1),
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
                                "Estimated Sulfur: $_sulfurEstimate",
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
                            padding: const EdgeInsets.fromLTRB(30, 6, 0, 0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                "Estimated Hp: $_healthEstimate",
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
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 0),
                      padding: const EdgeInsets.all(0),
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.5,
                      decoration: BoxDecoration(
                        color: const Color(0xff2f3130),
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                            color: const Color(0xff3f4241), width: 1),
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
                                "Items to raid",
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
                                  crossAxisAlignment:
                                      CrossAxisAlignment.center,
                                  mainAxisSize: MainAxisSize.max,
                                  children: _listOfRaid,
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
