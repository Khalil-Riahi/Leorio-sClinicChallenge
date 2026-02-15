import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'models/patient.dart';
import 'models/appointment.dart';
import 'models/treatment.dart';
import 'screens/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  // Register adapters
  Hive.registerAdapter(PatientAdapter());
  Hive.registerAdapter(AppointmentAdapter());
  Hive.registerAdapter(TreatmentAdapter());

  // Open boxes
  await Hive.openBox<Patient>('patients');
  await Hive.openBox<Appointment>('appointments');
  await Hive.openBox<Treatment>('treatments');

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
