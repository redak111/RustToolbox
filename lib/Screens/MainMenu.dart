import 'package:flutter/material.dart';

import 'CameraFreq.dart';
import 'DecayTimer.dart';
import 'RaidCalculator.dart';
import 'Settings.dart';

class MainMenu extends StatelessWidget {
  const MainMenu({super.key});

  @override
  Widget build(BuildContext context) {
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
            "Home",
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
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    height: 120,
                    width: 120,
                    clipBehavior: Clip.antiAlias,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                    ),
                    child: Image.asset("images/Icon.png", fit: BoxFit.cover),
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Text(
                  "Welcome to Rust Toolbox",
                  textAlign: TextAlign.start,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    color: Color(0x9a8c8c8c),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(w * 0.06, 20, 0, 0),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Changelog",
                    textAlign: TextAlign.start,
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontStyle: FontStyle.normal,
                      fontSize: 14,
                      color: Color(0x998c8c8c),
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 5, 0, 0),
                  padding: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.17,
                  decoration: BoxDecoration(
                    color: const Color(0xff2f3130),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    border: Border.all(color: const Color(0xb33f4241), width: 1),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          const Padding(
                            padding: EdgeInsets.fromLTRB(10, 5, 0, 0),
                            child: Text(
                              "02.12.2022",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                                fontSize: 12,
                                color: Color(0xc08c8c8c),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(w * 0.62, 5, 0, 0),
                            child: const Text(
                              "0.01",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w300,
                                fontStyle: FontStyle.normal,
                                fontSize: 12,
                                color: Color(0xc18c8c8c),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: const [
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                            child: Icon(
                              Icons.add,
                              color: Color(0xbe8c8c8c),
                              size: 25,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.fromLTRB(5, 5, 0, 0),
                            child: Text(
                              "FEATURES",
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
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "· Raid Cost (Already Damaged - Mode)",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 13,
                              color: Color(0xbf8c8c8c),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "· Decay notification delay",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 13,
                              color: Color(0xbf8c8c8c),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "· Decay timer",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 13,
                              color: Color(0xbf8c8c8c),
                            ),
                          ),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.fromLTRB(40, 0, 0, 0),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "· Camera and Frequency Ids",
                            textAlign: TextAlign.start,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.normal,
                              fontSize: 13,
                              color: Color(0xbf8c8c8c),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
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
