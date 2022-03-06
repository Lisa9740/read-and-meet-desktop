import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ram_admin/core/providers/user.provider.dart';


class RenderCurrentUserData extends StatelessWidget {
  const RenderCurrentUserData({Key? key, required Function this.view}) : super(key: key);
  final view;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: Provider.of<UserApiProvider>(context, listen: false).getCurrent(),
        builder: (ct, userSnapshot) {
          if (userSnapshot.connectionState == ConnectionState.waiting) {
            return Center(
                  child: CircularProgressIndicator(),

            );
          }
          var user = userSnapshot.data;
          print('user $user');
          return view(user);

        });
  }
}