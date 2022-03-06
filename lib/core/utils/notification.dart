import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class NotificationMsg {
  static void showSnackBar(
      String message,
      bool isSuccess,
      BuildContext context,
      ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: const Duration(seconds: 5),
        content: Text(message),
        backgroundColor:
        isSuccess ? Colors.green : Colors.red,
      ),
    );
  }

  static void showTopSnackbar(
      context,
      String message
      ){
    showTopSnackBar(
        context,
        CustomSnackBar.success(
          message: message,
        )
    );

  }
}