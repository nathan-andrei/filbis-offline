import '../model/collections.dart';

extension QuestionTranslationExtension on QuestionTranslation {
  String? getTranslation(String language) {
    switch (language) {
      case 'filipino':
        return tagalogResponse;
      case 'English':
        return englishResponse;
      case 'cebuano':
        return cebuanoResponse;
      default:
        return tagalogResponse;
    }
  }
}

extension QckReplyExtension on QckReply {
  List<String>? getTranslation(String language) {
    switch (language) {
      case 'filipino':
        return tagalogReplies;
      case 'English':
        return englishReplies;
      case 'cebuano':
        return cebuanoReplies;
      default:
        return tagalogReplies;
    }
  }
}