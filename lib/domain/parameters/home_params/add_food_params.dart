class AddFoodsParams {
  int food_id;
  String type;
  int number;

  AddFoodsParams({
    required this.food_id,
    required this.type,
    required this.number,
  });

  Map<String, dynamic> toJson() => {
        "food_id": food_id,
        "type": type.toLowerCase(),
        "grams": number,
      };
}
