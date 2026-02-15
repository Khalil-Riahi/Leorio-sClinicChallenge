import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../models/treatment.dart';
import '../models/patient.dart';
import 'add_treatment_screen.dart';

class TreatmentsScreen extends StatelessWidget {
  const TreatmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final box = Hive.box<Treatment>('treatments');
    final patientsBox = Hive.box<Patient>('patients');

    return Scaffold(
      appBar: AppBar(title: const Text("Treatments")),
      body: ValueListenableBuilder(
        valueListenable: box.listenable(),
        builder: (context, Box<Treatment> box, _) {
          if (box.isEmpty) {
            return const Center(child: Text("No treatments"));
          }

          return ListView.builder(
            itemCount: box.length,
            itemBuilder: (context, index) {
              final treatment = box.getAt(index)!;
              final patient = patientsBox.get(treatment.patientKey);

              return Dismissible(
                key: Key(treatment.key.toString()),
                onDismissed: (_) => treatment.delete(),
                background: Container(color: Colors.red),
                child: ListTile(
                  title: Text(patient?.name ?? "Unknown"),
                  subtitle: Text(treatment.description),
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
            MaterialPageRoute(builder: (_) => const AddTreatmentScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
