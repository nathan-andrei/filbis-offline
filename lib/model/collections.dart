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