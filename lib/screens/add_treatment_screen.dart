import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/treatment.dart';
import '../models/patient.dart';

class AddTreatmentScreen extends StatefulWidget {
  const AddTreatmentScreen({super.key});

  @override
  State<AddTreatmentScreen> createState() => _AddTreatmentScreenState();
}

class _AddTreatmentScreenState extends State<AddTreatmentScreen> {
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  int? _selectedPatientKey;

  @override
  Widget build(BuildContext context) {
    final patientsBox = Hive.box<Patient>('patients');
    final treatmentsBox = Hive.box<Treatment>('treatments');

    return Scaffold(
      appBar: AppBar(title: const Text("Add Treatment")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<int>(
              hint: const Text("Select Patient"),
              items: patientsBox.keys.map((key) {
                final patient = patientsBox.get(key)!;
                return DropdownMenuItem(
                  value: key as int,
                  child: Text(patient.name),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedPatientKey = value;
                });
              },
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: "Description"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedPatientKey == null) return;

                treatmentsBox.add(
                  Treatment(
                    patientKey: _selectedPatientKey!,
                    date: _selectedDate,
                    description: _descriptionController.text,
                  ),
                );

                Navigator.pop(context);
              },
              child: const Text("Save"),
            ),
          ],
        ),
      ),
    );
  }
}
