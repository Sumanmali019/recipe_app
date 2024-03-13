import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:recepi_application/presentation/search/controllers/search.controller.dart';
import 'package:recepi_application/presentation/search/widget/search_loaded.dart';

import '../home/home_widget/home_saffold.dart';

class SearchScreen extends GetView<SearchrecepiController> {
  const SearchScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AnnotatedScaffold(
      child: LayoutBuilder(
        builder: (context, constraints) {
          final avatarWaitingDuration = 400.ms;
          final nameDelayDuration =
              avatarWaitingDuration + avatarWaitingDuration + 200.ms;
          final namePlayDuration = 800.ms;
          nameDelayDuration + namePlayDuration - 400.ms;

          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: InkWell(
                    onTap: () {
                      Get.back();
                    },
                    child: const Icon(
                      Icons.arrow_back_ios_new,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 18,
                  left: 22,
                  right: 22,
                ),
                child: TextFormField(
                  controller: controller.searchController,
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                  decoration: InputDecoration(
                    labelText: 'Search for a recipe',
                    labelStyle: const TextStyle(
                      color: Colors.black,
                    ),
                    hintText: 'Enter a recipe name',
                    hintStyle: const TextStyle(
                      color: Colors.grey,
                    ),
                    fillColor: Colors.white,
                    filled: true,
                    enabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.black, width: 2.0),
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    suffixIcon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    ),
                  ),
                  onFieldSubmitted: (_) => controller
                      .searchRecipes(controller.searchController.text),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: 50,
                width: 207,
                child: ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.black),
                    elevation: MaterialStateProperty.all(6),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      const EdgeInsets.symmetric(
                          vertical: 15.0, horizontal: 30.0),
                    ),
                  ),
                  onPressed: () {
                    String query = controller.searchController.text;
                    FocusScope.of(context).unfocus();
                    controller.searchRecipes;
                    if (query.isNotEmpty) {
                      controller.searchRecipes(
                          query); // Use the captured text for searching
                      controller.searchController
                          .clear(); // Clear the text field after initiating the search
                    }
                  },
                  child: const Text(
                    'Search',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
              Expanded(child: Obx(() {
                if (controller.isLoading.isTrue) {
                  return Center(
                    child:
                        Lottie.asset('assets/images/loading.json', height: 270),
                  );
                } else if (controller.searchResults.isEmpty &&
                    controller.lastSearchQuery.isNotEmpty) {
                  return Center(
                    child: Text(
                      'No results found for "${controller.lastSearchQuery}"',
                      style:
                          GoogleFonts.alice(fontSize: 22, color: Colors.black),
                    ),
                  );
                } else {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (controller.lastSearchQuery.isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 10),
                          child: Text(
                            'Showing results for "${controller.lastSearchQuery}"',
                            style: GoogleFonts.alice(
                                fontSize: 20, color: Colors.black),
                          ),
                        ),
                      Expanded(
                        child: LoadedsearchRecipesWidget(
                            recipes: controller.searchrecipes,
                            constraints: constraints),
                      ),
                    ],
                  );
                }
              })),
            ],
          );
        },
      ),
    );
  }
}
