import 'package:ram_admin/core/constants/color_constants.dart';
import 'package:ram_admin/responsive.dart';

import 'package:ram_admin/screens/dashboard/components/mini_information_card.dart';

import 'package:ram_admin/screens/dashboard/components/recent_users.dart';
import 'package:ram_admin/screens/dashboard/components/user_details_widget.dart';
import 'package:flutter/material.dart';

import '../../models/user.dart';
import 'components/header.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key,  required this.user}) : super(key: key);
  final User user;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        //padding: EdgeInsets.all(defaultPadding),
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          child: Column(
            children: [
              Header(user: user),
              SizedBox(height: defaultPadding),
              MiniInformation(),
              SizedBox(height: defaultPadding),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: Column(
                      children: [
                        //MyFiels(),
                        //SizedBox(height: defaultPadding),
                        RecentUsers(),
                        SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context))
                          SizedBox(height: defaultPadding),
                        if (Responsive.isMobile(context)) UserDetailsWidget(),
                      ],
                    ),
                  ),
                  if (!Responsive.isMobile(context))
                    SizedBox(width: defaultPadding),
                  // On Mobile means if the screen is less than 850 we dont want to show it


                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
