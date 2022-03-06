import 'package:ram_admin/core/utils/storage.dart';
import 'package:ram_admin/responsive.dart';
import 'package:flutter/material.dart';
import 'package:ram_admin/screens/dashboard/dashboard_screen.dart';

import '../../core/widgets/render.current.user.data.dart';
import '../../models/user.dart';
import '../login/login_screen.dart';
import 'components/side_menu.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/';


  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoggedIn = false;
  var currentUser;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {


    autoLogIn(context) async {
      var user = await Storage().get("user");

      print("test $user");
      if (user != null) {
        setState(() {
          currentUser = User.fromJson(user);
          isLoggedIn = true;
        });
        return;
      }
    }




    if (!isLoggedIn) {
      print(isLoggedIn);
      return FutureBuilder(
        future: autoLogIn(context),
        builder: (ct, authSnapshot) {

          if (authSnapshot.connectionState ==
              ConnectionState.waiting) {
            return Container();
          }
          return Login(title: "Bienvenue sur le dashboard ReadAndMeet",);
        },
      );
    } else {
      return view(currentUser);
    }



  }

  view(User user) {
    return Scaffold(
      //key: context.read<MenuController>().scaffoldKey,
      drawer: SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),
            Expanded(
              // It takes 5/6 part of the screen
              flex: 5,
              child: DashboardScreen(user: user),
            ),
          ],
        ),
      ),
    );
  }
}
