import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/patient.dart';

class PatientForm extends StatefulWidget {
  final Patient? patient;

  const PatientForm({super.key, this.patient});

  @override
  State<PatientForm> createState() => _PatientFormState();
}

class _PatientFormState extends State<PatientForm> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (widget.patient != null) {
      _nameController.text = widget.patient!.name;
      _phoneController.text = widget.patient!.phone;
      _notesController.text = widget.patient!.notes;
    }
  }

  void _save() {
    final box = Hive.box<Patient>('patients');

    if (widget.patient == null) {
      box.add(Patient(
        name: _nameController.text,
        phone: _phoneController.text,
        notes: _notesController.text,
      ));
    } else {
      widget.patient!
        ..name = _nameController.text
        ..phone = _phoneController.text
        ..notes = _notesController.text
        ..save();
    }

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Patient")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(controller: _nameController, decoration: const InputDecoration(labelText: "Name")),
            TextField(controller: _phoneController, decoration: const InputDecoration(labelText: "Phone")),
            TextField(controller: _notesController, decoration: const InputDecoration(labelText: "Notes")),
            const SizedBox(height: 20),
            ElevatedButton(onPressed: _save, child: const Text("Save")),
          ],
        ),
      ),
    );
  }
}
