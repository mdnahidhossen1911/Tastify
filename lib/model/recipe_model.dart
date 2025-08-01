class RecipeModel {
  final String? id;
  final String userId;
  final String title;
  final String? photo;
  final String? instructions;
  final String? ingredients;
  final String? nutritionInfo;
  final String? cid;
  final String? category_name;
  final String? description;
  final String? prepTime;
  final String? cookTime;

  RecipeModel({
    this.id,
    required this.userId,
    required this.title,
    this.photo,
    this.instructions,
    this.ingredients,
    this.nutritionInfo,
    this.cid,
    this.category_name,
    this.description,
    this.prepTime,
    this.cookTime,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      userId: json['user_id'],
      title: json['title'],
      photo: json['photo'],
      instructions: json['instructions'],
      ingredients: json['ingredients'],
      nutritionInfo: json['nutrition_info'],
      cid: json['cid'],
      category_name: json['category_name'],
      description: json['description'],
      prepTime: json['prep_time'],
      cookTime: json['cook_time'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'user_id': userId,
      'title': title,
      'photo': photo,
      'instructions': instructions,
      'ingredients': ingredients,
      'nutrition_info': nutritionInfo,
      'cid': cid,
      'category_name': category_name,
      'description': description,
      'prep_time': prepTime,
      'cook_time': cookTime,
    };
  }
}
