import 'package:flutter/material.dart';
import 'package:recepies_app/models/recipe.dart';
import 'package:recepies_app/pages/recipe_page.dart';
import 'package:recepies_app/services/data_service.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String mealTypeFilter = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("RecipBook"),
      ),
      body: SafeArea(child: _buildUi()),
    );
  }

  Widget _buildUi() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          _recipeTypeButton(),
          _recipestList(),
        ],
      ),
    );
  }

  Widget _recipeTypeButton() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.05,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  mealTypeFilter = "snack";
                });
              },
              child: const Text("🥕Snack"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  mealTypeFilter = "breakfast";
                });
              },
              child: const Text("🍝Breakfast"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  mealTypeFilter = "lunch";
                });
              },
              child: const Text("🍕Lunch"),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5.0),
            child: FilledButton(
              onPressed: () {
                setState(() {
                  mealTypeFilter = "dinner";
                });
              },
              child: const Text("🍖Dinner"),
            ),
          ),
        ],
      ),
    );
  }

  Widget _recipestList() {
    return FutureBuilder(
      future: DataService().getRecipes(mealTypeFilter),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (snapshot.hasError) {
          return const Text("Unable to load data");
        }
        return ListView.builder(
          itemCount: snapshot.data!.length,
          itemBuilder: (context, index) {
            Recipe recipe = snapshot.data![index];
            return ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecipePage(
                      recipe: recipe,
                    ),
                  ),
                );
              },
              contentPadding: const EdgeInsets.only(top: 20),
              isThreeLine: true,
              leading: Image.network(recipe.image),
              title: Text(recipe.name),
              subtitle:
                  Text("${recipe.cuisine}\n Difficulty:${recipe.difficulty}"),
              trailing: Text(
                "${recipe.rating.toString()} ⭐",
                style: const TextStyle(fontSize: 15),
              ),
            );
          },
        );
      },
    );
  }
}
