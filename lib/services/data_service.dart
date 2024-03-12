import 'package:recepies_app/models/recipe.dart';
import 'package:recepies_app/services/http_service.dart';

class DataService {
  static final DataService _singleton = DataService._internal();

  final _httpService = HTTPService();

  factory DataService() {
    return _singleton;
  }

  DataService._internal();

  Future<List<Recipe>?> getRecipes(String filter) async {
    String path = "recipes/";
    if (filter.isNotEmpty) {
      path += "meal-type/$filter";
    }
    var response = await _httpService.get(path);
    if (response?.statusCode == 200 && response?.data != null) {
      final data = response!.data["recipes"];
      List<Recipe> recipes = data.map((e) => Recipe.fromJson(e)).toList();
      print(recipes);
      return recipes;
    }
  }
}
