import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/appointment.dart';
import '../models/patient.dart';

class AddAppointmentScreen extends StatefulWidget {
  const AddAppointmentScreen({super.key});

  @override
  State<AddAppointmentScreen> createState() => _AddAppointmentScreenState();
}

class _AddAppointmentScreenState extends State<AddAppointmentScreen> {
  final _reasonController = TextEditingController();
  DateTime? _selectedDate;
  int? _selectedPatientKey;

  @override
  Widget build(BuildContext context) {
    final patientsBox = Hive.box<Patient>('patients');
    final appointmentsBox = Hive.box<Appointment>('appointments');

    return Scaffold(
      appBar: AppBar(title: const Text("Add Appointment")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            DropdownButtonFormField<int>(
              hint: const Text("Select Patient"),
              items:
                  patientsBox.keys.map((key) {
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
            ElevatedButton(
              onPressed: () async {
                final date = await showDatePicker(
                  context: context,
                  firstDate: DateTime(2020),
                  lastDate: DateTime(2100),
                  initialDate: DateTime.now(),
                );

                if (date == null) return;

                final time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );

                if (time == null) return;

                setState(() {
                  _selectedDate = DateTime(
                    date.year,
                    date.month,
                    date.day,
                    time.hour,
                    time.minute,
                  );
                });
              },
              child: const Text("Pick Date & Time"),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _reasonController,
              decoration: const InputDecoration(labelText: "Reason"),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedPatientKey == null || _selectedDate == null)
                  return;

                appointmentsBox.add(
                  Appointment(
                    patientKey: _selectedPatientKey!,
                    dateTime: _selectedDate!,
                    reason: _reasonController.text,
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
