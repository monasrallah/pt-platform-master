class FilterCoachesParams {
  String name;
  List<int> categoriesId;

  FilterCoachesParams({required this.name, required this.categoriesId});

  Map<String, dynamic> toJson() => {
        "name": name,
        "cat_ids": categoriesId,
      };
}
