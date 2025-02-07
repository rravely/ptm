import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isKorean = true;
  bool isDarkMode = false;
  bool isNotificationEnabled = false;
  double fontSize = 16.0;
  TimeOfDay? notificationTime;

  @override
  void initState() {
    super.initState();
    _loadSettings();
  }

  Future<void> _loadSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isKorean = prefs.getBool('isKorean') ?? true;
      isDarkMode = prefs.getBool('isDarkMode') ?? false;
      isNotificationEnabled = prefs.getBool('isNotificationEnabled') ?? false;
      fontSize = prefs.getDouble('fontSize') ?? 16.0;
      int? hour = prefs.getInt('notificationHour');
      int? minute = prefs.getInt('notificationMinute');
      if (hour != null && minute != null) {
        notificationTime = TimeOfDay(hour: hour, minute: minute);
      }
    });
  }

  Future<void> _saveSettings() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isKorean', isKorean);
    await prefs.setBool('isDarkMode', isDarkMode);
    await prefs.setBool('isNotificationEnabled', isNotificationEnabled);
    await prefs.setDouble('fontSize', fontSize);
    if (notificationTime != null) {
      await prefs.setInt('notificationHour', notificationTime!.hour);
      await prefs.setInt('notificationMinute', notificationTime!.minute);
    }
  }

  Future<void> _pickNotificationTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: notificationTime ?? TimeOfDay.now(),
    );
    if (pickedTime != null) {
      setState(() {
        notificationTime = pickedTime;
      });
      _saveSettings();
    }
  }

  void _resetData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    setState(() {
      isKorean = true;
      isDarkMode = false;
      isNotificationEnabled = false;
      fontSize = 16.0;
      notificationTime = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(isKorean ? '설정' : 'Settings')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: ListView(
          children: [
            SwitchListTile(
              title: Text(isKorean ? '언어: 한글' : 'Language: English'),
              value: isKorean,
              onChanged: (value) {
                setState(() {
                  isKorean = value;
                });
                _saveSettings();
              },
            ),
            ListTile(
              title: Text(isKorean ? '폰트 크기' : 'Font Size'),
              subtitle: Slider(
                min: 12.0,
                max: 24.0,
                value: fontSize,
                onChanged: (value) {
                  setState(() {
                    fontSize = value;
                  });
                  _saveSettings();
                },
              ),
            ),
            SwitchListTile(
              title: Text(isKorean ? '알림 활성화' : 'Enable Notifications'),
              value: isNotificationEnabled,
              onChanged: (value) {
                setState(() {
                  isNotificationEnabled = value;
                });
                _saveSettings();
              },
            ),
            if (isNotificationEnabled)
              ListTile(
                title: Text(isKorean ? '알림 시간 설정' : 'Set Notification Time'),
                subtitle: Text(notificationTime != null
                    ? notificationTime!.format(context)
                    : (isKorean ? '시간 선택' : 'Pick a Time')),
                onTap: _pickNotificationTime,
              ),
            SwitchListTile(
              title: Text(isKorean ? '다크 모드' : 'Dark Mode'),
              value: isDarkMode,
              onChanged: (value) {
                setState(() {
                  isDarkMode = value;
                });
                _saveSettings();
              },
            ),
            ListTile(
              title: Text(isKorean ? '데이터 초기화' : 'Reset Data'),
              trailing: Icon(Icons.delete, color: Colors.red),
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: Text(isKorean ? '데이터 초기화' : 'Reset Data'),
                    content: Text(isKorean
                        ? '캘린더에 저장된 모든 데이터를 삭제하시겠습니까?'
                        : 'Do you want to delete all saved calendar data?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(isKorean ? '취소' : 'Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          _resetData();
                          Navigator.pop(context);
                        },
                        child: Text(isKorean ? '확인' : 'Confirm'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
