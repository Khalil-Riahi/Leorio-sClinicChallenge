import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/patient.dart';
import 'patient_form.dart';

class PatientsScreen extends StatelessWidget {
  const PatientsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Patient>('patients');

    return Scaffold(
      appBar: AppBar(title: const Text("Patients")),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Patient> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No patients yet"));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final patient = box.getAt(index)!;

              return Dismissible(
                key: Key(patient.key.toString()),
                onDismissed: (_) => patient.delete(),
                background: Container(color: Colors.red),
                child: ListTile(
                  title: Text(patient.name),
                  subtitle: Text(patient.phone),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => PatientForm(patient: patient),
                      ),
                    );
                  },
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const PatientForm()),
          );
        },
      ),
    );
  }
}
