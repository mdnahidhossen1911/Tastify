import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  const SectionHeader({super.key, required this.title, required this.seeAll});

  final String title;
  final VoidCallback seeAll;

  @override
  Widget build(BuildContext context) {
    TextTheme textTheme=Theme.of(context).textTheme;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,style: textTheme.titleMedium),
        TextButton(onPressed: seeAll, child: Text('See All', style: textTheme.titleSmall))
      ],
    );
  }
}
