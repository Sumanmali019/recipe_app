import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:recepi_application/presentation/search/widget/search_time_line.dart';
import '../../../domain/model/edaman.dart';
import '../../catgeory/widgets/animated_app_bar.dart';
import '../../catgeory/widgets/reciepi_information.dart';
import '../../home/home_widget/home_saffold.dart';
import '../../onbording/widgets/animated_dish_widget.dart';

class EdamamRecipeDetail extends StatefulWidget {
  final EdamamRecipeModel recipeModel;
  const EdamamRecipeDetail({super.key, required this.recipeModel});

  @override
  State<EdamamRecipeDetail> createState() => _EdamamRecipeDetailState();
}

class _EdamamRecipeDetailState extends State<EdamamRecipeDetail> {
  @override
  Widget build(BuildContext context) {
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
                    'Serving': widget.recipeModel.servings,
                    'prepTime': widget.recipeModel.cookingTime,
                  },
                  infoDelayTime: infoDelayTime,
                  infoPlayTime: infoPlayTime,
                  constraints: constraints),
            ],
          ),
        );
      }),
    );
  }
}
