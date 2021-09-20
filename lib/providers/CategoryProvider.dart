import 'package:flutter/material.dart';
import 'package:my_first_app/models/category.dart';
import 'package:my_first_app/services/api.dart';

class CategoryProvider extends ChangeNotifier {
  List<Category> categories = [];
  late ApiService apiService;

  CategoryProvider() {
    this.apiService = ApiService();

    init();
  }

  Future init() async {
    categories = await apiService.fetchCategories();
    notifyListeners();
  }

  Future<void> updateCategory(Category category) async {
    try {
      Category updatedCategory = await apiService.updateCategory(category);
      int index = categories.indexOf(category);
      categories[index] = updatedCategory;

      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }

  Future<void> deleteCategory(Category category) async {
    try {
      await apiService.deleteCategory(category.id);

      categories.remove(category);
      notifyListeners();
    } catch (Exception) {
      print(Exception);
    }
  }
}