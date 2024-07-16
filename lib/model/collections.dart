import 'package:isar/isar.dart';

part 'collections.g.dart';

// Run: dart run build_runner build

@collection
class Module {
  Id id = Isar.autoIncrement;
  late String name;
  List<SubModule> subModule = List.empty(growable: true);
  List<String> order = List.empty(growable: true);
}

@embedded
class SubModule {
  // final qckReply = IsarLink<qck_reply>();
  QckReply? qckReply;
  QuestionTranslation? questionTranslation;
  Mobile? mobile;
  late String name;
}

@embedded
class QckReply {
  // int id = Isar.autoIncrement;
  List<String>? cebuanoReplies;
  List<String>? englishReplies;
  List<String>? tagalogReplies;
}

@embedded
class QuestionTranslation {
  String? cebuanoResponse;
  String? englishResponse;
  String? tagalogResponse;
}

@embedded 
class Mobile {
  String? dataKey;
  String? yesNext;
  String? next;
}

@collection
class ChildrenHealthData {
  Id id = Isar.autoIncrement;
  late String uid; // format -> (school)-(id_number)
  
  late MedicalHistory medicalHistory;
}

@embedded
class MedicalHistory {
  String name = 'medical_history';
 
  List<MedicalRecord> medicalRecords = List.empty(growable: true);
}

@embedded 
class MedicalRecord {
  late String uid; // format -> med_rec_(module_name)_(datetime)
  late String sessionName = ""; // not utilized yet for mobile version :thinking:
  late String createdAt;
  late String updatedAt; // as of creation, this isn't utilized at all in web app, so will not be used here yet

  List<KeyValuePair> records = []; // e.g. []
}

@embedded 
class KeyValuePair {
  late String key;
  late String value;
}