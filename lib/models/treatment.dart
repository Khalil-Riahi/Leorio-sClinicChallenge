import 'package:hive/hive.dart';

part 'treatment.g.dart';

@HiveType(typeId: 2)
class Treatment extends HiveObject {
  @HiveField(0)
  int patientKey;

  @HiveField(1)
  DateTime date;

  @HiveField(2)
  String description;

  Treatment({
    required this.patientKey,
    required this.date,
    required this.description,
  });
}
