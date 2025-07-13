import 'package:flutter/material.dart';

class RecipeFormScreen extends StatefulWidget {
  @override
  _RecipeFormScreenState createState() => _RecipeFormScreenState();
}

class _RecipeFormScreenState extends State<RecipeFormScreen> {
  final List<String> tags = [];
  final List<TextEditingController> ingredients = [TextEditingController()];
  final List<TextEditingController> instructions = [TextEditingController()];
  final TextEditingController tagController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  @override
  void dispose() {
    tagController.dispose();
    notesController.dispose();
    for (var c in ingredients) c.dispose();
    for (var c in instructions) c.dispose();
    super.dispose();
  }

  void addTag() {
    final tag = tagController.text.trim();
    if (tag.isNotEmpty) {
      setState(() {
        tags.add(tag);
        tagController.clear();
      });
    }
  }

  void handleSubmit() {
    // Collect non-empty ingredients
    final ingredientList = ingredients
        .map((controller) => controller.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    // Collect non-empty instructions
    final instructionList = instructions
        .map((controller) => controller.text.trim())
        .where((text) => text.isNotEmpty)
        .toList();

    // Notes
    final notes = notesController.text.trim();

    // Result object
    final recipeData = {
      'tags': tags,
      'ingredients': ingredientList,
      'instructions': instructionList,
      'notes': notes.isEmpty ? null : notes,
    };

    print("==== Recipe Form Submitted ====");
    print(recipeData);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Recipe Creator")),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            // Tags
            Text("Tags"),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: tagController,
                    decoration: InputDecoration(
                      hintText: "Add tags (e.g. vegetarian, spicy)",
                    ),
                  ),
                ),
                SizedBox(width: 8),
                ElevatedButton(
                  onPressed: addTag,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.pinkAccent,
                  ),
                  child: Text("Add"),
                ),
              ],
            ),
            Wrap(
              spacing: 6,
              children: tags.map((tag) => Chip(label: Text(tag))).toList(),
            ),
            SizedBox(height: 16),

            // Ingredients
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("INGREDIENTS", style: TextStyle(fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    setState(() {
                      ingredients.add(TextEditingController());
                    });
                  },
                  child: Text("+ Add"),
                ),
              ],
            ),
            Column(
              children: List.generate(ingredients.length, (index) {
                return Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: ingredients[index],
                        decoration: InputDecoration(hintText: "Ingredient"),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        setState(() {
                          ingredients.removeAt(index);
                        });
                      },
                    ),
                  ],
                );
              }),
            ),
            SizedBox(height: 16),

            // Instructions
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("INSTRUCTIONS", style: TextStyle(fontWeight: FontWeight.bold)),
                TextButton(
                  onPressed: () {
                    setState(() {
                      instructions.add(TextEditingController());
                    });
                  },
                  child: Text("+ Add"),
                ),
              ],
            ),
            Column(
              children: List.generate(instructions.length, (index) {
                return Row(
                  children: [
                    CircleAvatar(
                      radius: 12,
                      child: Text("${index + 1}", style: TextStyle(fontSize: 12)),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: TextField(
                        controller: instructions[index],
                        maxLines: null,
                        decoration: InputDecoration(hintText: "Describe this step..."),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.delete, color: Colors.redAccent),
                      onPressed: () {
                        setState(() {
                          instructions.removeAt(index);
                        });
                      },
                    ),
                  ],
                );
              }),
            ),
            SizedBox(height: 16),

            // Notes
            Text("NOTES (OPTIONAL)", style: TextStyle(fontWeight: FontWeight.bold)),
            TextField(
              controller: notesController,
              maxLines: null,
              decoration: InputDecoration(
                hintText: "Add any additional notes or tips...",
              ),
            ),
            SizedBox(height: 24),

            // Submit Button
            Center(
              child: ElevatedButton(
                onPressed: handleSubmit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                ),
                child: Text("Submit", style: TextStyle(fontSize: 16)),
              ),
            ),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
