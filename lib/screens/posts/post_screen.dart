import 'package:ram_admin/core/constants/color_constants.dart';
import 'package:flutter/material.dart';

class PostsScreen extends StatelessWidget {
  const PostsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(defaultPadding),
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Wrap(children:[Text("test")])
            ],
          ),
        ),
      ),
    );
  }
}
