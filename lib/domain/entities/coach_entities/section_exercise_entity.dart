class SectionExercisesEntity {
  int id;
  String title;
  List<CategoryExercisesEntity> category;

  SectionExercisesEntity({
    required this.id,
    required this.title,
    required this.category,
  });
}

class CategoryExercisesEntity {
  int id;
  String title;
  List<ExercisesEntity> exercises;

  CategoryExercisesEntity({
    required this.id,
    required this.title,
    required this.exercises,
  });
}

class ExercisesEntity {
  int id;
  String title;
  String description;
  String icon;

  ExercisesEntity({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
  });
}
