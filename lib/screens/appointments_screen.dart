import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/appointment.dart';
import '../models/patient.dart';
import 'add_appointment_screen.dart';
class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Appointment>('appointments');
    final patientsBox = Hive.box<Patient>('patients');

    return Scaffold(
      appBar: AppBar(title: const Text("Appointments")),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Appointment> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No appointments"));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final appointment = box.getAt(index)!;
              final patient = patientsBox.get(appointment.patientKey);

              return Dismissible(
                key: Key(appointment.key.toString()),
                onDismissed: (_) => appointment.delete(),
                background: Container(color: Colors.red),
                child: ListTile(
                  title: Text(patient?.name ?? "Unknown"),
                  subtitle: Text(appointment.reason),
                  trailing: Checkbox(
                    value: appointment.isDone,
                    onChanged: (val) {
                      appointment.isDone = val ?? false;
                      appointment.save();
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
  onPressed: () {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const AddAppointmentScreen()),
    );
  },
  child: const Icon(Icons.add),
),

    );
  }
}
