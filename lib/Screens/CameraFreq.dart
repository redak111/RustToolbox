import 'package:flutter/material.dart';

import 'DecayTimer.dart';
import 'MainMenu.dart';
import 'RaidCalculator.dart';
import 'Settings.dart';

class CamerasFreq extends StatelessWidget {
  const CamerasFreq({super.key});

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
            "CCameras & Frequencies",
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
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Text(
                  "Cameras",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 25,
                    color: Color(0x9a8c8c8c),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  padding: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: const Color(0xff2f3130),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    border:
                        Border.all(color: const Color(0xbe3f4241), width: 1),
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, h * 0.015, 0, 0),
                            child: const Text(
                              "Airfield",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(w * 0.37, h * 0.015, 0, 0),
                            child: const Text(
                              "AIRFIELDHELIPAD",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  padding: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.09,
                  decoration: BoxDecoration(
                    color: const Color(0xff2f3130),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    border:
                        Border.all(color: const Color(0xbe3f4241), width: 1),
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, h * 0.015, 0, 0),
                            child: const Text(
                              "Bandit Camp",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(w * 0.275, h * 0.015, 0, 0),
                            child: const Text(
                              "TOWNWEAPONS",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(w * 0.685, h * 0.005, 0, 0),
                        child: const Text(
                          "CASINO",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  padding: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.09,
                  decoration: BoxDecoration(
                    color: const Color(0xff2f3130),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    border:
                        Border.all(color: const Color(0xbe3f4241), width: 1),
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, h * 0.015, 0, 0),
                            child: const Text(
                              "Dome",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(w * 0.59, h * 0.015, 0, 0),
                            child: const Text(
                              "DOME1",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.65, h * 0.005, 0, 0),
                        child: const Text(
                          "DOMETOP",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  padding: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.39,
                  decoration: BoxDecoration(
                    color: const Color(0xff2f3130),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    border:
                        Border.all(color: const Color(0xbe3f4241), width: 1),
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, h * 0.015, 0, 0),
                            child: const Text(
                              "Large Oil Rig",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(w * 0.35, h * 0.015, 0, 0),
                            child: const Text(
                              "OILRIG2HELI",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.58, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG2DOCK",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.51, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG2EXHAUST",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.64, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG2L1",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.64, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG2L2",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.62, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG2L3A",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.62, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG2L3B",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.64, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG2L4",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.64, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG2L5",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.62, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG2L6A",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.62, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG2L6B",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.62, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG2L6C",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.62, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG2L6D",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  padding: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.115,
                  decoration: BoxDecoration(
                    color: const Color(0xff2f3130),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    border:
                        Border.all(color: const Color(0xbe3f4241), width: 1),
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, h * 0.015, 0, 0),
                            child: const Text(
                              "Outpost",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(w * 0.315, h * 0.015, 0, 0),
                            child: const Text(
                              "COMPOUNDSTREET",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.49, h * 0.005, 0, 0),
                        child: const Text(
                          "COMPOUNDMUSIC",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.fromLTRB(w * 0.485, h * 0.005, 0, 0),
                        child: const Text(
                          "COMPOUNDCRUDE",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  padding: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.22,
                  decoration: BoxDecoration(
                    color: const Color(0xff2f3130),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    border:
                        Border.all(color: const Color(0xbe3f4241), width: 1),
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, h * 0.015, 0, 0),
                            child: const Text(
                              "Small Oil Rig",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(w * 0.35, h * 0.015, 0, 0),
                            child: const Text(
                              "OILRIG1HELI",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.58, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG1DOCK",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.51, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG1EXHAUST",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.64, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG1L1",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.64, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG1L2",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.64, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG1L3",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.64, h * 0.005, 0, 0),
                        child: const Text(
                          "OILRIG1L4",
                          textAlign: TextAlign.left,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0x808c8c8c),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.fromLTRB(0, 12, 0, 0),
                child: Text(
                  "Frequencies",
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.clip,
                  style: TextStyle(
                    letterSpacing: 2.0,
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 25,
                    color: Color(0x9a8c8c8c),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  padding: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: const Color(0xff2f3130),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    border:
                        Border.all(color: const Color(0xbe3f4241), width: 1),
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, h * 0.015, 0, 0),
                            child: const Text(
                              "Large Excavator Pit",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(w * 0.35, h * 0.015, 0, 0),
                            child: const Text(
                              "4777",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.fromLTRB(0, 12, 0, 0),
                  padding: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: const Color(0xff2f3130),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    border:
                        Border.all(color: const Color(0xbe3f4241), width: 1),
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, h * 0.015, 0, 0),
                            child: const Text(
                              "Large Oil Rig",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(w * 0.49, h * 0.015, 0, 0),
                            child: const Text(
                              "4768",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  margin: EdgeInsets.fromLTRB(0, 12, 0, h * 0.03),
                  padding: const EdgeInsets.all(0),
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.06,
                  decoration: BoxDecoration(
                    color: const Color(0xff2f3130),
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10.0),
                    border:
                        Border.all(color: const Color(0xbe3f4241), width: 1),
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
                          Padding(
                            padding: EdgeInsets.fromLTRB(10, h * 0.015, 0, 0),
                            child: const Text(
                              "Small Oil Rig",
                              textAlign: TextAlign.start,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontStyle: FontStyle.normal,
                                fontSize: 16,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                          Padding(
                            padding:
                                EdgeInsets.fromLTRB(w * 0.485, h * 0.015, 0, 0),
                            child: const Text(
                              "4765",
                              textAlign: TextAlign.left,
                              overflow: TextOverflow.clip,
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontStyle: FontStyle.normal,
                                fontSize: 14,
                                color: Color(0x808c8c8c),
                              ),
                            ),
                          ),
                        ],
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
