class FoodModel {
  int userTarget;
  UserTargetModel user;
  int foodTarget;
  int exerciseTarget;
  int carb;
  int fat;
  int protein;
  EatModel food;

  FoodModel({
    required this.userTarget,
    required this.user,
    required this.foodTarget,
    required this.exerciseTarget,
    required this.carb,
    required this.fat,
    required this.protein,
    required this.food,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) => FoodModel(
        userTarget: json["user_target"],
        user: UserTargetModel.fromJson(json["user"]),
        foodTarget: json["food_target"],
        exerciseTarget: json["exercise_target"],
        carb: json["carb"],
        fat: json["fat"],
        protein: json["protein"],
        food: EatModel.fromJson(json["food"]),
      );

  Map<String, dynamic> toJson() => {
        "user_target": userTarget,
        "user": user.toJson(),
        "food_target": foodTarget,
        "exercise_target": exerciseTarget,
        "carb": carb,
        "fat": fat,
        "protein": protein,
        "food": food.toJson(),
      };
}

class EatModel {
  List<DishesModel>? breakfast;
  List<DishesModel>? dinner;
  List<DishesModel>? snack;
  List<DishesModel>? supplements;
  List<DishesModel>? lunch;

  EatModel({
    this.breakfast,
    this.dinner,
    this.snack,
    this.supplements,
    this.lunch,
  });

  factory EatModel.fromJson(Map<String, dynamic> json) => EatModel(
        breakfast: List<DishesModel>.from(
            json["breakfast"].map((x) => DishesModel.fromJson(x))),
        dinner: List<DishesModel>.from(
            json["dinner"].map((x) => DishesModel.fromJson(x))),
        snack: List<DishesModel>.from(
            json["snack"].map((x) => DishesModel.fromJson(x))),
        supplements: List<DishesModel>.from(
            json["supplements"].map((x) => DishesModel.fromJson(x))),
        lunch: List<DishesModel>.from(
            json["lunch"].map((x) => DishesModel.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "breakfast": List<dynamic>.from(breakfast!.map((x) => x.toJson())),
        "dinner": List<dynamic>.from(dinner!.map((x) => x.toJson())),
        "snack": List<dynamic>.from(snack!.map((x) => x.toJson())),
        "supplements": List<dynamic>.from(supplements!.map((x) => x.toJson())),
        "lunch": List<dynamic>.from(lunch!.map((x) => x.toJson())),
      };
}

class DishesModel {
  int userFoodId;
  int id;
  String sku;
  double calorie;
  double carb;
  double fat;
  double protein;
  String name;
  String title;

  DishesModel({
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

  factory DishesModel.fromJson(Map<String, dynamic> json) => DishesModel(
        userFoodId: json["user_food_id"],
        id: json["id"],
        sku: json["sku"],
        calorie: json["calorie"]?.toDouble(),
        carb: json["carb"]?.toDouble(),
        fat: json["fat"]?.toDouble(),
        protein: json["protein"]?.toDouble(),
        name: json["name"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "user_food_id": userFoodId,
        "id": id,
        "sku": sku,
        "calorie": calorie,
        "carb": carb,
        "fat": fat,
        "protein": protein,
        "name": name,
        "title": title,
      };
}

class UserTargetModel {
  int targetCalorie;
  int targetCarb;
  int targetFat;
  int targetProtein;

  UserTargetModel({
    required this.targetCalorie,
    required this.targetCarb,
    required this.targetFat,
    required this.targetProtein,
  });

  factory UserTargetModel.fromJson(Map<String, dynamic> json) =>
      UserTargetModel(
        targetCalorie: json["target_calorie"],
        targetCarb: json["target_carb"],
        targetFat: json["target_fat"],
        targetProtein: json["target_protein"],
      );

  Map<String, dynamic> toJson() => {
        "target_calorie": targetCalorie,
        "target_carb": targetCarb,
        "target_fat": targetFat,
        "target_protein": targetProtein,
      };
}

class AllAddFoodModel {
  List<AddFoodModel> foods;

  AllAddFoodModel({required this.foods});

  factory AllAddFoodModel.fromJson(Map<String, dynamic> json) {
    List<AddFoodModel> all = [];
    for (var element in (json['foods'] as List<dynamic>)) {
      all.add(AddFoodModel.fromJson(element as Map<String, dynamic>));
    }
    return AllAddFoodModel(foods: all);
  }
}

class AddFoodModel {
  int id;
  String sku;
  double calorie;
  double carb;
  double fat;
  double protein;
  String name;
  String title;

  AddFoodModel({
    required this.id,
    required this.sku,
    required this.calorie,
    required this.carb,
    required this.fat,
    required this.protein,
    required this.name,
    required this.title,
  });

  factory AddFoodModel.fromJson(Map<String, dynamic> json) => AddFoodModel(
        id: json["id"],
        sku: json["sku"],
        calorie: json["calorie"]?.toDouble(),
        carb: json["carb"]?.toDouble(),
        fat: json["fat"]?.toDouble(),
        protein: json["protein"]?.toDouble(),
        name: json["name"],
        title: json["title"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "sku": sku,
        "calorie": calorie,
        "carb": carb,
        "fat": fat,
        "protein": protein,
        "name": name,
        "title": title,
      };
}
