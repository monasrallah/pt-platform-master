class EditNameParams {
  String firstName;
  String lastName;

  EditNameParams({
    required this.firstName,
    required this.lastName,
  });

  Map<String, dynamic> toJson() => {
        "first_name": firstName,
        "last_name": lastName,
      };
}
