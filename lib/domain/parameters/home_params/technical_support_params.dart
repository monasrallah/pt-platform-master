class TechnicalSupportParams {
  String subject;
  String message;

  TechnicalSupportParams({required this.subject, required this.message});

  Map<String, dynamic> toJson() => {
        "subject": subject,
        "message": message,
      };
}
