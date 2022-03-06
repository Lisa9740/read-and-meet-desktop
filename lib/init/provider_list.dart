import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../core/providers/auth.provider.dart';
import '../core/providers/user.provider.dart';

//import '../navigation/navigation_service.dart';

class ApplicationProvider {
  static ApplicationProvider? _instance;
  static ApplicationProvider? get instance {
    _instance ??= ApplicationProvider._init();
    return _instance;
  }

  ApplicationProvider._init();

  List<SingleChildWidget> singleItems = [];
  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(create: (ctx) => AuthApiProvider()),
    ChangeNotifierProxyProvider<AuthApiProvider, UserApiProvider>(
      create: (ctx) => UserApiProvider(),
      update: (ct, auth, prevState) => UserApiProvider(
        authToken: auth.token,
      ),
    ),

    //ChangeNotifierProvider(
    //  create: (_) => MenuController(),
    //),

//    Provider.value(value: NavigationService.instance)
  ];
  List<SingleChildWidget> uiChangesItems = [];
}
