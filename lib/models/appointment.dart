import 'package:hive/hive.dart';

part 'appointment.g.dart';

@HiveType(typeId: 1)
class Appointment extends HiveObject {
  @HiveField(0)
  int patientKey;

  @HiveField(1)
  DateTime dateTime;

  @HiveField(2)
  String reason;

  @HiveField(3)
  bool isDone;

  Appointment({
    required this.patientKey,
    required this.dateTime,
    required this.reason,
    this.isDone = false,
  });
}
