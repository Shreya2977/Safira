// 📍 lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import 'trip_screen.dart';
import 'sos_screen.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Safira'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Welcome Card
            _buildWelcomeCard(),
            SizedBox(height: 30),

            // Start Trip Button
            _buildActionButton(
              icon: Icons.directions_walk,
              text: 'Start New Trip',
              color: Color(0xFF6C63FF),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => TripScreen()),
                );
              },
            ),
            SizedBox(height: 20),

            // Emergency SOS Button
            _buildActionButton(
              icon: Icons.warning,
              text: 'EMERGENCY SOS',
              color: Colors.red,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SosScreen()),
                );
              },
            ),

            Spacer(),

            // Safety Tips
            _buildSafetyTips(),
          ],
        ),
      ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          children: [
            Icon(Icons.security, size: 50, color: Color(0xFF6C63FF)),
            SizedBox(height: 10),
            Text(
              'Stay Safe on Your Journey',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'We\'ll check in on you every 15 minutes during your trip',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, size: 24),
      label: Padding(
        padding: EdgeInsets.symmetric(vertical: 15),
        child: Text(
          text,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
        ),
      ),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 3,
      ),
    );
  }

  Widget _buildSafetyTips() {
    return Container(
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '💡 Safety Tips',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text('• Share your live location with trusted contacts'),
          SizedBox(height: 5),
          Text('• Keep phone charged during travel'),
          SizedBox(height: 5),
          Text('• Respond to safety check-ins'),
        ],
      ),
    );
  }
}
