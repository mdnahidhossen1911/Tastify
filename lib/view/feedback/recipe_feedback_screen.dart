import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tastify/service_locator.dart';

import '../../res/component/circle_progress.dart';
import '../../res/component/recipe_feedback_widget.dart';
import '../../view_model/fatch_recipe_feedback_view_model.dart';

class RecipeFeedbackScreen extends StatefulWidget {
  const RecipeFeedbackScreen({super.key});

  static const String name = '/recipe-feedback';

  @override
  State<RecipeFeedbackScreen> createState() => _RecipeFeedbackScreenState();
}

class _RecipeFeedbackScreenState extends State<RecipeFeedbackScreen> {
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
