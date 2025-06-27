import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../data_repository/dbHelper.dart';
import '../models/recipe_model.dart';

class RecipeClass extends ChangeNotifier {
  RecipeClass() {
    getRecipes();
  }

  bool isDark = false;
  changeIsDark() {
    isDark = !isDark;
    notifyListeners();
  }

  TextEditingController nameController = TextEditingController();
  TextEditingController preperationTimeController = TextEditingController();
  TextEditingController instructionsController = TextEditingController();
  TextEditingController ingredientsController = TextEditingController();
  File? image;

  List<RecipeModel> allRecipes = [];
  List<RecipeModel> favoriteRecipes = [];
  getRecipes() async {
    allRecipes = await DbHelper.dbHelper.getAllRecipes();
    favoriteRecipes = allRecipes.where((e) => e.isFavorite).toList();
    notifyListeners();
  }

  /// this func is for get data from the server
  Future<void> syncWithServer() async {
    try {
      final localRecipes =
          await DbHelper.dbHelper.getAllRecipes(); // بيانات SQLite
      final url = Uri.parse('http://192.168.43.240:5000/recipes');
      // 1. إرسال كل وصفات SQLite إلى السيرفر
      // final localRecipes = await DbHelper.dbHelper.getAllRecipes();
      // for (var recipe in localRecipes) {
      //   await http.post(
      //     url,
      //     headers: {'Content-Type': 'application/json'},
      //     body: json.encode(recipe.toJson()),
      //   );
      // }
      final response = await http.get(url);
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final serverRecipes =
            data.map((json) => RecipeModel.fromJson(json)).toList();
        // دمج الاثنين
        allRecipes = [...localRecipes, ...serverRecipes];
        // تحويل البيانات من JSON إلى RecipeModel بدون حفظها في SQLite
        //allRecipes = data.map((json) => RecipeModel.fromJson(json)).toList();
        // favoriteRecipes = allRecipes.where((e) => e.isFavorite).toList();
        notifyListeners();
      } else {
        print('Error from API: ${response.statusCode}');
      }
    } catch (e) {
      print("sync error $e");
    }
  }

  Future<void> loadAllData() async {
    await syncWithServer(); // تحديث من السيرفر
  }

  insertNewRecipe() {
    getRecipes();
    RecipeModel recipeModel = RecipeModel(
      name: nameController.text,
      isFavorite: false,
      image: image,
      ingredients: ingredientsController.text,
      instructions: instructionsController.text,
      preperationTime: int.parse(
        preperationTimeController.text != ''
            ? preperationTimeController.text
            : '0',
      ),
    );
    DbHelper.dbHelper.insertNewRecipe(recipeModel);
    getRecipes();
  }

  updateRecipe(RecipeModel recipeModel) async {
    await DbHelper.dbHelper.updateRecipe(recipeModel);
    getRecipes();
  }

  updateIsFavorite(RecipeModel recipeModel) {
    DbHelper.dbHelper.updateIsFavorite(recipeModel);
    getRecipes();
  }

  deleteRecipe(RecipeModel recipeModel) {
    DbHelper.dbHelper.deleteRecipe(recipeModel);
    getRecipes();
  }
}
// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// import '../data_repository/dbHelper.dart';
// import '../models/recipe_model.dart';

// class RecipeClass extends ChangeNotifier {
//   RecipeClass() {
//     loadAllData();

//   }

//   bool isDark = false;
//   changeIsDark() {
//     isDark = !isDark;
//     notifyListeners();
//   }

//   TextEditingController nameController = TextEditingController();
//   TextEditingController preperationTimeController = TextEditingController();
//   TextEditingController instructionsController = TextEditingController();
//   TextEditingController ingredientsController = TextEditingController();
//   File? image;

//   List<RecipeModel> allRecipes = [];
//   List<RecipeModel> favoriteRecipes = [];

//   // ✅ تحميل من SQLite فقط
//   Future<void> _loadFromSQLite() async {
//     allRecipes = await DbHelper.dbHelper.getAllRecipes();
//     favoriteRecipes = allRecipes.where((e) => e.isFavorite).toList();
//     notifyListeners();
//   }

//   // ✅ تحميل من API ثم تخزينه محليًا
//   Future<void> syncWithServer() async {
//     try {
//       final url = Uri.parse('http://177.10.1.242:5000/recipes');

//       // 1. إرسال كل وصفات SQLite إلى السيرفر
//       // final localRecipes = await DbHelper.dbHelper.getAllRecipes();
//       // for (var recipe in localRecipes) {
//       //   await http.post(
//       //     url,
//       //     headers: {'Content-Type': 'application/json'},
//       //     body: json.encode(recipe.toJson()),
//       //   );
//       // }

//       // 2. بعد إرسال البيانات، جلب البيانات من السيرفر
//       final response = await http.get(url);

//       if (response.statusCode == 200) {
//         final List<dynamic> data = json.decode(response.body);

//         // 3. حذف وصفات SQLite القديمة
//         // await DbHelper.dbHelper.clearAllRecipes();

//         // 4. تخزين وصفات السيرفر في SQLite
//         allRecipes = data.map((json) => RecipeModel.fromJson(json)).toList();
//         for (var recipe in allRecipes) {
//           await DbHelper.dbHelper.insertNewRecipe(recipe);
//         }

//         favoriteRecipes = allRecipes.where((e) => e.isFavorite).toList();
//         notifyListeners();
//       } else {
//         print('Error from API: ${response.statusCode}');
//       }
//     } catch (e) {
//       print('Sync Error: $e');
//     }
//   }

//   // ✅ دالة رئيسية لتحميل الكل
//   Future<void> loadAllData() async {
//     await _loadFromSQLite(); // مبدئيًا
//     await syncWithServer(); // تحديث من السيرفر
//   }

//   Future<void> insertNewRecipe() async {
//     final recipe = RecipeModel(
//       // id: DateTime.now().millisecondsSinceEpoch, // أو null إذا السيرفر يولّد id
//       name: nameController.text,
//       isFavorite: false,
//       image: image,
//       preperationTime: int.tryParse(preperationTimeController.text) ?? 0,
//       ingredients: ingredientsController.text,
//       instructions: instructionsController.text,
//     );

//     // 1. حفظ محلي في SQLite
//     await DbHelper.dbHelper.insertNewRecipe(recipe);
//     getRecipes();

//     // 2. إرسال إلى السيرفر
//     // final url = Uri.parse('http://177.10.1.242:5000/recipes');
//     // try {
//     //   final response = await http.post(
//     //     url,
//     //     headers: {'Content-Type': 'application/json'},
//     //     body: json.encode(recipe.toJson()),
//     //   );

//     //   if (response.statusCode == 200) {
//     //     print('✅ تم إرسال الوصفة إلى السيرفر');
//     //   } else {
//     //     print('❌ فشل الإرسال إلى السيرفر: ${response.statusCode}');
//     //   }
//     // } catch (e) {
//     //   print('🚫 خطأ في الاتصال بالسيرفر: $e');
//     // }

//     // // تحديث القائمة
//     // allRecipes.add(recipe);
//     // notifyListeners();
//   }

//   // insertNewRecipe() {
//   //   RecipeModel recipeModel = RecipeModel(
//   //     name: nameController.text,
//   //     isFavorite: false,
//   //     image: image,
//   //     ingredients: ingredientsController.text,
//   //     instructions: instructionsController.text,
//   //     preperationTime: int.parse(
//   //       preperationTimeController.text != ''
//   //           ? preperationTimeController.text
//   //           : '0',
//   //     ),
//   //   );
//   //   DbHelper.dbHelper.insertNewRecipe(recipeModel);
//   //   loadAllData();
//   // }

//   updateRecipe(RecipeModel recipeModel) async {
//     await DbHelper.dbHelper.updateRecipe(recipeModel);
//     loadAllData();
//   }

//   updateIsFavorite(RecipeModel recipeModel) {
//     DbHelper.dbHelper.updateIsFavorite(recipeModel);
//     loadAllData();
//   }

//   deleteRecipe(RecipeModel recipeModel) {
//     DbHelper.dbHelper.deleteRecipe(recipeModel);
//     loadAllData();
//   }
// }
