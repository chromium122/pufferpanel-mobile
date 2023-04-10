import 'package:flutter/material.dart';

void showError(BuildContext context, String errorMessage) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      errorMessage,
      style: TextStyle(color: Theme.of(context).colorScheme.onError),
    ),
    backgroundColor: Theme.of(context).colorScheme.error,
  ));
}
