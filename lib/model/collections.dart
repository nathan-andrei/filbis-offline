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

  @override
  String toString() => "name: $name";
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

  @override
  String toString() => 'Mobile[data_key: $dataKey, \nnext: $next, \nyes_Next: $yesNext]';
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
  late String uid = ""; // format -> med_rec_(module_name)_(datetime)
  late String sessionName = ""; // sorry we didn't implement this rin because not used at all in webapp ^_^
  late String createdAt = "";
  late String updatedAt = ""; // as of creation, this isn't utilized at all in web app, so will not be used here yet
  late String module = "";
  late String mainQuestion = "";

  List<KeyValuePair> records = List.empty(growable: true);
}

@embedded 
class KeyValuePair {
  late String key;
  late String value;
}