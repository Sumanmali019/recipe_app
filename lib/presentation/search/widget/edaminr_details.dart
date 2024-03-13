import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import '../../../domain/model/edaman.dart';

class EdamamRecipeDetail extends StatefulWidget {
  final EdamamRecipeModel recipeModel;
  const EdamamRecipeDetail({super.key, required this.recipeModel});

  @override
  State<EdamamRecipeDetail> createState() => _EdamamRecipeDetailState();
}

class _EdamamRecipeDetailState extends State<EdamamRecipeDetail> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: SafeArea(
        child: SlidingUpPanel(
          minHeight: size.height / 2,
          maxHeight: size.height / 1.15,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
          parallaxEnabled: true,
          body: SingleChildScrollView(
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Hero(
                    tag: widget.recipeModel.image,
                    child: Image(
                      height: (size.height / 2) + 60,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      image: NetworkImage(widget.recipeModel.image),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: InkWell(
                    onTap: () => Navigator.pop(context),
                    child: const Icon(
                      CupertinoIcons.back,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                ),
              ],
            ),
          ),
          panel: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5,
                    width: 40,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(
                        0.3,
                      ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Text(
                  widget.recipeModel.title,
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Text(
                      "cal",
                      style: TextStyle(color: Colors.black),
                    ),
                    const Icon(
                      Icons.monitor_heart,
                      color: Colors.red,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.recipeModel.kcal.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.timer,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.recipeModel.cookingTime.toString(),
                      style: TextStyle(color: Colors.black),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    Container(
                      color: Colors.black,
                      height: 30,
                      width: 3,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.person,
                      color: Colors.black,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      "${widget.recipeModel.servings} Servings",
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Divider(
                  color: Colors.black.withOpacity(0.3),
                ),
                Expanded(
                  child: DefaultTabController(
                    length: 2,
                    initialIndex: 0,
                    child: Column(
                      children: [
                        TabBar(
                          isScrollable: false,
                          labelColor: Colors.black,
                          labelStyle: const TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                          indicator: const UnderlineTabIndicator(
                            borderSide: BorderSide(
                              color: Colors.black,
                              width: 4.0,
                            ),
                          ),
                          unselectedLabelColor: Colors.grey,
                          tabs: [
                            Tab(
                              text: "Ingredients".toUpperCase(),
                            ),
                            Tab(
                              text: "Cook".toUpperCase(),
                            ),
                          ],
                        ),
                        Expanded(
                          child: TabBarView(
                            children: [
                              EdamamIngredients(
                                  edamamrecipeModel: widget.recipeModel),
                              EdamamCooking(
                                edamamrecipeModel: widget.recipeModel,
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class EdamamIngredients extends StatefulWidget {
  final EdamamRecipeModel edamamrecipeModel;
  const EdamamIngredients({required this.edamamrecipeModel, super.key});

  @override
  State<EdamamIngredients> createState() => _EdamamIngredientsState();
}

class _EdamamIngredientsState extends State<EdamamIngredients> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          ListView.separated(
            physics: const ScrollPhysics(),
            shrinkWrap: true,
            itemCount: widget.edamamrecipeModel.ingredients.length,
            separatorBuilder: (BuildContext context, int index) {
              return Divider(
                color: Colors.black.withOpacity(0.3),
              );
            },
            itemBuilder: (BuildContext context, int index) {
              return Row(
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        widget.edamamrecipeModel.takedingredients[index] =
                            !widget.edamamrecipeModel.takedingredients[index];
                      });
                    },
                    child: Icon(
                      color: Colors.black,
                      widget.edamamrecipeModel.takedingredients[index]
                          ? Icons.task_alt
                          : Icons.circle_outlined,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: Text(
                      widget.edamamrecipeModel.ingredients[index],
                      style: const TextStyle(fontSize: 14, color: Colors.black),
                    ),
                  ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class EdamamCooking extends StatefulWidget {
  final EdamamRecipeModel edamamrecipeModel;
  const EdamamCooking({required this.edamamrecipeModel, super.key});

  @override
  State<EdamamCooking> createState() => _EdamamCookingState();
}

class _EdamamCookingState extends State<EdamamCooking> {
  @override
  void initState() {
    if (widget.edamamrecipeModel.url.contains('http://')) {
      widget.edamamrecipeModel.url =
          widget.edamamrecipeModel.url.replaceFirst('http://', 'https://');
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: InAppWebView(
        gestureRecognizers: {
          Factory<VerticalDragGestureRecognizer>(
              () => VerticalDragGestureRecognizer())
        },
        initialUrlRequest: URLRequest(
          url: Uri.parse(widget.edamamrecipeModel.url),
        ),
        // ignore: deprecated_member_use
        initialOptions: InAppWebViewGroupOptions(
          // ignore: deprecated_member_use
          crossPlatform: InAppWebViewOptions(),
        ),
        onWebViewCreated: (InAppWebViewController controller) {},
      ),
    );
  }
}
