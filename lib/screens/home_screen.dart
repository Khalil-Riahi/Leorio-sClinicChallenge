import 'package:flutter/material.dart';
import 'patients_screen.dart';
import 'appointments_screen.dart';
import 'treatments_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Clinic Manager')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              child: const Text("Patients"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const PatientsScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text("Appointments"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const AppointmentsScreen()),
                );
              },
            ),
            ElevatedButton(
              child: const Text("Treatments"),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const TreatmentsScreen()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
