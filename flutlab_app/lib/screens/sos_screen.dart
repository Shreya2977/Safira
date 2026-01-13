// 📍 lib/screens/sos_screen.dart
import 'package:flutter/material.dart';

class SosScreen extends StatefulWidget {
  @override
  _SosScreenState createState() => _SosScreenState();
}

class _SosScreenState extends State<SosScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  bool _alertSent = false;
  List<String> _contacts = ['Mom', 'Dad', 'Friend'];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 1),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendEmergencyAlert() {
    setState(() {
      _alertSent = true;
    });

    // Simulate sending alert
    Future.delayed(Duration(seconds: 2), () {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: Text('✅ Alert Sent!'),
          content: Text('Emergency contacts notified with your live location.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('OK'),
            ),
          ],
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red[50],
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated SOS Icon
              ScaleTransition(
                scale: Tween(begin: 0.9, end: 1.1).animate(_controller),
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.warning,
                    color: Colors.white,
                    size: 80,
                  ),
                ),
              ),
              SizedBox(height: 30),

              // Emergency Text
              Text(
                'EMERGENCY SOS',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Press the button below to send alert',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 30),

              // Alert Status
              if (_alertSent)
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(15),
                    child: Column(
                      children: [
                        Icon(Icons.check_circle, color: Colors.green, size: 40),
                        SizedBox(height: 10),
                        Text(
                          'Alert sent to:',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 10),
                        ..._contacts.map((contact) => ListTile(
                              leading: Icon(Icons.person),
                              title: Text(contact),
                              trailing: Icon(Icons.check, color: Colors.green),
                            )),
                      ],
                    ),
                  ),
                ),
              Spacer(),

              // SOS Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _alertSent ? null : _sendEmergencyAlert,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Text(
                      _alertSent ? 'ALERT SENT' : 'SEND EMERGENCY ALERT',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    disabledBackgroundColor: Colors.grey,
                  ),
                ),
              ),
              SizedBox(height: 10),

              // Cancel Button
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Cancel',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
