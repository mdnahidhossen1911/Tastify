import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../res/component/circle_progress.dart';
import '../../../../res/component/recipe_feedback_widget.dart';
import '../controller/fatch_recipe_feedback_controller.dart';

class RecipeFeedbackScreen extends StatefulWidget {
  const RecipeFeedbackScreen({super.key});

  static const String name = '/recipe-feedback';

  @override
  State<RecipeFeedbackScreen> createState() => _RecipeFeedbackScreenState();
}

class _RecipeFeedbackScreenState extends State<RecipeFeedbackScreen> {
  FatchRecipeFeedbackController fatchRecipeFeedbackController =
      FatchRecipeFeedbackController();

  @override
  void initState() {
    // TODO: implement initState
    fatchRecipeFeedbackController.fetchFeedbacks();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text('Feedback', style: textTheme.headlineSmall),
      ),
      body: SafeArea(
        child: GetBuilder(
          init: fatchRecipeFeedbackController,
          builder: (controller) {
            return controller.isLoading
                ? circleProgress()
                : ListView.builder(
                  itemCount: controller.feedbacks.length,
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemBuilder: (context, index) {
                    return RecipeFeedbackWidget(
                      feedback: controller.feedbacks[index],
                    );
                  },
                );
          },
        ),
      ),
    );
  }
}
