import '../data_repository/item_dbHelper.dart';

class ItemModel {
  late int? id;
  late String name;
  late bool isComplete;
  ItemModel({
    /// the construcure
    this.id,
    required this.name,
    required this.isComplete,
  });

  Map<String, dynamic> toMap() {
    //// convert the object to map to make the sqlite understand it
    return {
      ItemDbHelper.dbHelper.idColumn: id,
      ItemDbHelper.dbHelper.nameColumn: name,
      ItemDbHelper.dbHelper.isCompleteColumn: isComplete ? 1 : 0,
    };
  }

  factory ItemModel.fromMap(Map<String, dynamic> m) {
    return ItemModel(
      id: m[ItemDbHelper.dbHelper.idColumn],
      name: m[ItemDbHelper.dbHelper.nameColumn],
      isComplete: m[ItemDbHelper.dbHelper.isCompleteColumn] == 1 ? true : false,
    );
  }
}
