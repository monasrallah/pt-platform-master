class RecipeEntity {
  int id;
  String? image;
  int? time;
  String? name;
  String title;
  String description;
  List<String>? ingredients;

  RecipeEntity({
    required this.id,
    required this.image,
    this.time,
    this.name,
    required this.title,
    required this.description,
    this.ingredients,
  });
}
