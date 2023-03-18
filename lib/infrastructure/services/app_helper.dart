import 'package:flutter/material.dart';

abstract class AppHelpers {
  AppHelpers._();

  static showConfirm(
      {required BuildContext context,
      required VoidCallback onSummit,
      required String title}) {
    return showDialog(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(
          'Confirm',
          style:
              Theme.of(context).textTheme.displayMedium?.copyWith(fontSize: 20),
        ),
        content: Text(
          title,
          style:
              Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 18),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                'No',
                style: Theme.of(context).textTheme.displayMedium,
              )),
          TextButton(
            onPressed: () {
              onSummit();
              Navigator.pop(context);
            },
            child: Text(
              'Yes',
              style: Theme.of(context).textTheme.displayMedium,
            ),
          ),
        ],
      ),
    );
  }
}
