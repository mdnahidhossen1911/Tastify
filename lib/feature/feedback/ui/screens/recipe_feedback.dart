import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tastify/core/utils/circle_progress.dart';
import 'package:tastify/feature/feedback/ui/controller/fatch_recipe_feedback_controller.dart';
import 'package:tastify/feature/feedback/ui/widget/recipe_feedback_widget.dart'
    show RecipeFeedbackWidget;

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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        forceMaterialTransparency: true,
        title: Text('Feedback', style: textTheme.titleLarge),
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
