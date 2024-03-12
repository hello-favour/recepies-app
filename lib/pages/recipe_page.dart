import 'package:flutter/material.dart';
import 'package:recepies_app/models/recipe.dart';

class RecipePage extends StatelessWidget {
  final Recipe recipe;
  const RecipePage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white60,
        title: const Text("RecipBook"),
      ),
      body: _buildUi(context),
    );
  }

  Widget _buildUi(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _recipeImage(context),
          _receipeDetails(context),
          _recipeIngredients(context),
        ],
      ),
    );
  }

  Widget _recipeImage(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.40,
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(recipe.image),
        ),
      ),
    );
  }

  Widget _receipeDetails(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${recipe.cuisine} ${recipe.difficulty}",
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            recipe.name,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            "Prep Time: ${recipe.prepTimeMinutes} Minutes | Cooks Time: ${recipe.cookTimeMinutes} Minutes",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
            ),
          ),
          Text(
            "${recipe.rating.toString()} ⭐| ${recipe.reviewCount} Reviews",
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _recipeIngredients(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
      child: Column(
        children: recipe.ingredients
            .map(
              (e) => Row(
                children: [
                  const Icon(
                    Icons.check_box,
                  ),
                  Text("$e"),
                ],
              ),
            )
            .toList(),
      ),
    );
  }

  Widget _recipeInstructions(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: recipe.instructions
            .map(
              (e) => Text(
                "${recipe.instructions.indexOf(e)}. $e\n",
                maxLines: 3,
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 15.0,
                ),
              ),
            )
            .toList(),
      ),
    );
  }
}
