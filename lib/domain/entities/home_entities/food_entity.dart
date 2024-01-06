class FoodEntity {
  int userTarget;
  UserTargetEntity user;
  int foodTarget;
  int exerciseTarget;
  int carb;
  int fat;
  int protein;
  EatEntity food;

  FoodEntity({
    required this.userTarget,
    required this.user,
    required this.foodTarget,
    required this.exerciseTarget,
    required this.carb,
    required this.fat,
    required this.protein,
    required this.food,
  });

  factory FoodEntity.init() {
    return FoodEntity(
        userTarget: 0,
        user: UserTargetEntity.init(),
        foodTarget: 0,
        exerciseTarget: 0,
        carb: 0,
        fat: 0,
        protein: 0,
        food: EatEntity.init());
  }

  factory FoodEntity.copyWith(FoodEntity foodEntity) {
    return FoodEntity(
        userTarget: foodEntity.userTarget,
        user: foodEntity.user,
        foodTarget: foodEntity.foodTarget,
        exerciseTarget: foodEntity.exerciseTarget,
        carb: foodEntity.carb,
        fat: foodEntity.fat,
        protein: foodEntity.protein,
        food: foodEntity.food);
  }
}

class EatEntity {
  List<DishesEntity>? breakfast;
  List<DishesEntity>? dinner;
  List<DishesEntity>? snack;
  List<DishesEntity>? supplements;
  List<DishesEntity>? lunch;

  EatEntity({
    required this.breakfast,
    required this.dinner,
    required this.snack,
    required this.supplements,
    required this.lunch,
  });

  factory EatEntity.init() {
    return EatEntity(
        breakfast: [], dinner: [], snack: [], supplements: [], lunch: []);
  }
}

class DishesEntity {
  int userFoodId;
  int id;
  String sku;
  double calorie;
  double carb;
  double fat;
  double protein;
  String name;
  String title;

  DishesEntity({
    required this.userFoodId,
    required this.id,
    required this.sku,
    required this.calorie,
    required this.carb,
    required this.fat,
    required this.protein,
    required this.name,
    required this.title,
  });
}

class UserTargetEntity {
  int targetCalorie;
  int targetCarb;
  int targetFat;
  int targetProtein;

  UserTargetEntity({
    required this.targetCalorie,
    required this.targetCarb,
    required this.targetFat,
    required this.targetProtein,
  });

  factory UserTargetEntity.init() {
    return UserTargetEntity(
        targetCalorie: 0, targetCarb: 0, targetFat: 0, targetProtein: 0);
  }
}

class AddFoodEntity {
  int id;
  String sku;
  double calorie;
  double carb;
  double fat;
  double protein;
  String name;
  String title;

  AddFoodEntity({
    required this.id,
    required this.sku,
    required this.calorie,
    required this.carb,
    required this.fat,
    required this.protein,
    required this.name,
    required this.title,
  });

  factory AddFoodEntity.init() {
    return AddFoodEntity(
        id: 1,
        sku: "",
        calorie: 0,
        carb: 0,
        fat: 0,
        protein: 0,
        name: "",
        title: "");
  }
}
