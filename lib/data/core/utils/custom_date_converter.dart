import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

class CustomDateTimeConverter implements JsonConverter<DateTime, String> {
  const CustomDateTimeConverter();

  @override
  DateTime fromJson(String json) {
    if (json.contains('.')) {
      json = json.substring(0, json.length - 1);
    }

    return DateFormat('yyyy-MM-ddTHH:mm:ssZ', 'en').parse(json, true).toLocal();
  }

  @override
  String toJson(DateTime? json) => json!.toIso8601String();
}
