import 'dart:io';

class RecipeModel {
  int? id;
  late String name;
  late bool isFavorite;
  File? image;
  late int preperationTime;
  late String ingredients;
  late String instructions;

  RecipeModel({
    this.id,
    required this.name,
    required this.isFavorite,
    this.image,
    required this.preperationTime,
    required this.ingredients,
    required this.instructions,
  });

  /// code under is using toMap and fromMap and this is for SQLite but toJson and fromJson is for API
  ///  here we use both of API and SQLite
  Map<String, dynamic> toMap() => {
    'id': id,
    'name': name,
    'isFavorite': isFavorite ? 1 : 0,
    'preperationTime': preperationTime,
    'ingredients': ingredients,
    'instructions': instructions,
    'image': image?.path ?? '',
  };

  factory RecipeModel.fromMap(Map<String, dynamic> map) => RecipeModel(
    id: map['id'],
    name: map['name'],
    isFavorite: map['isFavorite'] == 1,
    preperationTime: map['preperationTime'],
    ingredients: map['ingredients'],
    instructions: map['instructions'],
    image:
        (map['image'] != null && map['image'].toString().isNotEmpty)
            ? File(map['image'])
            : null,
  );
  //// Here we will change toMap to toJason
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isFavorite': isFavorite ? 1 : 0,
      'preperationTime': preperationTime,
      'ingredients': ingredients,
      'instructions': instructions,
      'image': image == null ? '' : image!.path,
    };
  }

  //// and here change fromMap to fromJson and map to json
  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      id: json['id'],
      name: json['name'],
      isFavorite: json['isFavorite'] == 1 ? true : false,
      preperationTime: json['preperationTime'],
      ingredients: json['ingredients'],
      instructions: json['instructions'],
      image:
          (json['image'] != null && json['image'].toString().isNotEmpty)
              ? File(json['image'])
              : null,
    );
  }
}
