// 📍 lib/screens/active_trip_screen.dart
import 'package:flutter/material.dart';
import 'dart:async';

class ActiveTripScreen extends StatefulWidget {
  final String destination;

  ActiveTripScreen({required this.destination});

  @override
  _ActiveTripScreenState createState() => _ActiveTripScreenState();
}

class _ActiveTripScreenState extends State<ActiveTripScreen> {
  int _checkInTimer = 15 * 60; // 15 minutes in seconds
  Timer? _timer;
  bool _isSafe = false;

  @override
  void initState() {
    super.initState();
    _startCheckInTimer();
  }

  void _startCheckInTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_checkInTimer > 0) {
          _checkInTimer--;
        } else {
          _showCheckInAlert();
          _checkInTimer = 15 * 60; // Reset to 15 minutes
        }
      });
    });
  }

  void _showCheckInAlert() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text('Safety Check-in'),
        content: Text('Are you safe at your current location?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isSafe = false;
              });
              _triggerEmergency();
            },
            child: Text('NO, HELP!', style: TextStyle(color: Colors.red)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              setState(() {
                _isSafe = true;
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Safety confirmed!')),
              );
            },
            child: Text('YES, I\'M SAFE'),
          ),
        ],
      ),
    );
  }

  void _triggerEmergency() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('🚨 Emergency Alert Sent!'),
        content: Text(
            'Your emergency contacts have been notified with your location.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    int minutes = _checkInTimer ~/ 60;
    int seconds = _checkInTimer % 60;

    return Scaffold(
      appBar: AppBar(
        title: Text('Active Journey'),
        actions: [
          IconButton(
            icon: Icon(Icons.location_on),
            onPressed: () {
              // Open map
            },
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Destination Card
            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Icon(Icons.location_on, color: Colors.blue),
                        SizedBox(width: 10),
                        Text(
                          'Destination:',
                          style: TextStyle(fontSize: 16),
                        ),
                      ],
                    ),
                    SizedBox(height: 5),
                    Text(
                      widget.destination,
                      style:
                          TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            // Next Check-in Timer
            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Next Safety Check-in',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      '$minutes:${seconds.toString().padLeft(2, '0')}',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF6C63FF),
                      ),
                    ),
                    SizedBox(height: 10),
                    Text(
                      'You will be asked if you\'re safe',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),

            // Last Check-in Status
            Card(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: [
                    Text(
                      'Last Check-in Status',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          _isSafe ? Icons.check_circle : Icons.warning,
                          color: _isSafe ? Colors.green : Colors.orange,
                          size: 40,
                        ),
                        SizedBox(width: 10),
                        Text(
                          _isSafe
                              ? 'You confirmed safety'
                              : 'No recent check-in',
                          style: TextStyle(fontSize: 18),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),

            // Emergency Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _triggerEmergency,
                icon: Icon(Icons.warning),
                label: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'EMERGENCY SOS',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),

            // End Trip Button
            OutlinedButton(
              onPressed: () {
                _timer?.cancel();
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Trip ended safely!')),
                );
              },
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Text('END TRIP'),
              ),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
