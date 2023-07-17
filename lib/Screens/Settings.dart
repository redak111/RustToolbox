import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsMenu extends StatefulWidget {
  const SettingsMenu({super.key});

  @override
  State<SettingsMenu> createState() => _SettingsMenu();
}

String _notificationDelay = "0 min";

class _SettingsMenu extends State<SettingsMenu> {
  Future<void> _setSettingsValue(int Value, String Setting) async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      prefs.setInt(Setting, Value);
    });
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _notificationDelay = "${prefs.getInt('notificationDelay') ?? 0} min";
    });
  }

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

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
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff2f3130),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.zero,
          ),
          title: const Text(
            "Settings",
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.normal,
              fontSize: 14,
              color: Color(0xbf8c8c8c),
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Color(0xbf8c8c8c),
              size: 24,
            ),
            onPressed: () => {Navigator.pop(context)},
          ),
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
                      const Padding(
                        padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
                        child: Text(
                          "Notification Delay ",
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.clip,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontStyle: FontStyle.normal,
                            fontSize: 14,
                            color: Color(0xbf8c8c8c),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.fromLTRB(w * 0.23, 0, 0, 0),
                        child: Container(
                            width: MediaQuery.of(context).size.width * 0.3,
                            height: MediaQuery.of(context).size.height * 0.06,
                            padding: const EdgeInsets.symmetric(
                                vertical: 4, horizontal: 8),
                            decoration: BoxDecoration(
                              color: const Color(0x4c1e201f),
                              border: Border.all(
                                  color: const Color(0x651e201f), width: 1),
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton(
                                dropdownColor: const Color(0x4c1e201f),
                                value: _notificationDelay,
                                items: [
                                  "0 min",
                                  "5 min",
                                  "10 min",
                                  "15 min"
                                ].map<DropdownMenuItem<String>>((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value),
                                  );
                                }).toList(),
                                style: const TextStyle(
                                  color: Color(0x7f8c8c8c),
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal,
                                ),
                                onChanged: (value) {
                                  setState(() {
                                    int val = int.parse(
                                        value.toString().split(" ")[0]);
                                    _setSettingsValue(val, "notificationDelay");
                                    _notificationDelay = value.toString();
                                  });
                                },
                                icon: const Icon(Icons.arrow_drop_down),
                                iconSize: 24,
                                iconEnabledColor: const Color(0x7f8c8c8c),
                                elevation: 8,
                                isExpanded: true,
                              ),
                            )),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
