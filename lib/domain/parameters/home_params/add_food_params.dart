class AddFoodsParams {
  int food_id;
  String type;
  int number;
  String? date;

  AddFoodsParams(
      {required this.food_id,
      required this.type,
      required this.number,
      this.date});

  Map<String, dynamic> toJson() => {
        "food_id": food_id,
        "type": type.toLowerCase(),
        "grams": number,
        if (date != null) "date": date,
      };
}
