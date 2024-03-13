import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:get/get.dart';
import 'package:recepi_application/presentation/search/widget/search_time_line.dart';
import '../../../domain/model/edaman.dart';
import '../../catgeory/widgets/animated_app_bar.dart';
import '../../catgeory/widgets/reciepi_information.dart';
import '../../home/home_widget/home_saffold.dart';
import '../../onbording/widgets/animated_dish_widget.dart';
import '../controllers/search.controller.dart';

class EdamamRecipeDetail extends StatefulWidget {
  final EdamamRecipeModel recipeModel;
  const EdamamRecipeDetail({super.key, required this.recipeModel});

  @override
  State<EdamamRecipeDetail> createState() => _EdamamRecipeDetailState();
}

class _EdamamRecipeDetailState extends State<EdamamRecipeDetail> {
  @override
  Widget build(BuildContext context) {
    final SearchrecepiController controller =
        Get.find<SearchrecepiController>();
    return AnnotatedScaffold(
      // assetPath: "assets/images/recipe_details.png",
      child: LayoutBuilder(builder: (context, constraints) {
        final appBarPlayTime = 800.ms;
        final appBarDelayTime = 400.ms;
        final infoDelayTime = appBarPlayTime + appBarDelayTime - 200.ms;
        final infoPlayTime = 500.ms;
        final dishPlayTime = 600.ms;
        return SearchTimeLineSlidingPanel(
            recipe: widget.recipeModel,
            constraints: constraints,
            body: Column(
              children: [
                AnimatedAppBarWidget(
                  name: widget.recipeModel.title,
                  appBarPlayTime: appBarPlayTime,
                  appBarDelayTime: appBarDelayTime,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.04,
                ),
                AnimatedDishWidget(
                  constraints: constraints,
                  imageUrl: widget.recipeModel.image,
                  dishPlayTime: dishPlayTime,
                ),
                SizedBox(
                  height: constraints.maxHeight * 0.06,
                ),
                AnimatedInfoWidget(
                    nutrition: {
                      'calories': widget.recipeModel.kcal,
                      'protein': widget.recipeModel.servings,
                      'prepTime': widget.recipeModel.cookingTime,
                    },
                    infoDelayTime: infoDelayTime,
                    infoPlayTime: infoPlayTime,
                    constraints: constraints),
              ],
            ));
      }),
    );
  }
}

// class EdamamIngredients extends StatefulWidget {
//   final EdamamRecipeModel edamamrecipeModel;
//   const EdamamIngredients({required this.edamamrecipeModel, super.key});

//   @override
//   State<EdamamIngredients> createState() => _EdamamIngredientsState();
// }

// class _EdamamIngredientsState extends State<EdamamIngredients> {
//   @override
//   Widget build(BuildContext context) {
//     return SingleChildScrollView(
//       child: Column(
//         children: [
//           const SizedBox(
//             height: 20,
//           ),
//           ListView.separated(
//             physics: const ScrollPhysics(),
//             shrinkWrap: true,
//             itemCount: widget.edamamrecipeModel.ingredients.length,
//             separatorBuilder: (BuildContext context, int index) {
//               return Divider(
//                 color: Colors.black.withOpacity(0.3),
//               );
//             },
//             itemBuilder: (BuildContext context, int index) {
//               return Row(
//                 children: [
//                   InkWell(
//                     onTap: () {
//                       setState(() {
//                         widget.edamamrecipeModel.takedingredients[index] =
//                             !widget.edamamrecipeModel.takedingredients[index];
//                       });
//                     },
//                     child: Icon(
//                       color: Colors.black,
//                       widget.edamamrecipeModel.takedingredients[index]
//                           ? Icons.task_alt
//                           : Icons.circle_outlined,
//                     ),
//                   ),
//                   const SizedBox(
//                     width: 10,
//                   ),
//                   Expanded(
//                     child: Text(
//                       widget.edamamrecipeModel.ingredients[index],
//                       style: const TextStyle(fontSize: 14, color: Colors.black),
//                     ),
//                   ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// class EdamamCooking extends StatefulWidget {
//   final EdamamRecipeModel edamamrecipeModel;
//   const EdamamCooking({required this.edamamrecipeModel, super.key});

//   @override
//   State<EdamamCooking> createState() => _EdamamCookingState();
// }

// class _EdamamCookingState extends State<EdamamCooking> {
//   @override
//   void initState() {
//     if (widget.edamamrecipeModel.url.contains('http://')) {
//       widget.edamamrecipeModel.url =
//           widget.edamamrecipeModel.url.replaceFirst('http://', 'https://');
//     }

//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: InAppWebView(
//         gestureRecognizers: {
//           Factory<VerticalDragGestureRecognizer>(
//               () => VerticalDragGestureRecognizer())
//         },
//         initialUrlRequest: URLRequest(
//           url: Uri.parse(widget.edamamrecipeModel.url),
//         ),
//         // ignore: deprecated_member_use
//         initialOptions: InAppWebViewGroupOptions(
//           // ignore: deprecated_member_use
//           crossPlatform: InAppWebViewOptions(),
//         ),
//         onWebViewCreated: (InAppWebViewController controller) {},
//       ),
//     );
//   }
// }
