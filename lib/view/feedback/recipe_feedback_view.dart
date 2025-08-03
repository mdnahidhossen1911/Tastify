import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastify/service_locator.dart';
import 'package:tastify/view_model/view_models.dart';

import '../../res/component/circle_progress.dart';
import '../../res/component/recipe_feedback_widget.dart';

class RecipeFeedbackView extends StatefulWidget {
  const RecipeFeedbackView({super.key});

  static const String name = '/recipe-feedback';

  @override
  State<RecipeFeedbackView> createState() => _RecipeFeedbackViewState();
}

class _RecipeFeedbackViewState extends State<RecipeFeedbackView> {
  final FetchRecipeFeedbackViewModel _fetchRecipeFeedbackViewModel =
      locator<FetchRecipeFeedbackViewModel>();

  @override
  void initState() {
    // TODO: implement initState
    _fetchRecipeFeedbackViewModel.fetchFeedbacks();
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
        child: ChangeNotifierProvider(
          create: (context) => _fetchRecipeFeedbackViewModel,
          child: Consumer<FetchRecipeFeedbackViewModel>(
            builder: (context, value, child) {
              return value.isLoading
                  ? circleProgress()
                  : ListView.builder(
                    itemCount: value.feedbacks.length,
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    itemBuilder: (context, index) {
                      return RecipeFeedbackWidget(
                        feedback: value.feedbacks[index],
                      );
                    },
                  );
            },
          ),
        ),
      ),
    );
  }
}
