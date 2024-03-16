import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:recepi_application/const_assets/theme/app_colors.dart';
import 'package:recepi_application/domain/model/edaman.dart';
import 'package:recepi_application/presentation/search/widget/edamin_ingrdient.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

class SearchAnimatedSlidingPanel extends AnimatedWidget {
  final EdamamRecipeModel recipe;
  final Widget body;
  final BoxConstraints constraints;
  final AnimationController ingredientController;
  final Duration baseDelayTime;
  final Duration slidingDuration;
  const SearchAnimatedSlidingPanel(
      {super.key,
      required this.recipe,
      required this.body,
      required this.constraints,
      required this.ingredientController,
      required this.baseDelayTime,
      required this.slidingDuration,
      required super.listenable});

  @override
  Widget build(BuildContext context) {
    final header = Container(
      height: 6,
      width: 50,
      alignment: Alignment.center,
      padding: const EdgeInsets.only(top: 20),
      margin: EdgeInsets.symmetric(
          horizontal: constraints.maxWidth * 0.4, vertical: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.white, width: 2),
      ),
    );
    return SlidingUpPanel(
        header: header,
        margin: const EdgeInsets.symmetric(horizontal: 10),
        color: AppColors.cardColor,
        maxHeight: constraints.maxHeight * 0.9,
        minHeight:
            constraints.maxHeight * (listenable as Animation<double>).value,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.white, width: 1),
        body: body,
        panel: Column(
          children: [
            const SizedBox(
              height: 30,
            ),
            SerachIngredientsCardList(
              ingredientController: ingredientController,
              recipe: recipe,
              delayTime: baseDelayTime,
              slidingDuration: slidingDuration,
            ),
            const SizedBox(
              height: 5,
            ),
            const Divider(
              color: Colors.white54,
            ),
            Expanded(
              child: EdamamCooking(edamamrecipeModel: recipe),
            )
          ],
        ));
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
