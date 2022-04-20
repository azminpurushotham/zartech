import 'package:zartech/base/app_theme.dart';
import 'package:zartech/router.gr.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'home/repository.dart';

class App extends MaterialApp {
  App({required Repository repository})
      : super(
          debugShowCheckedModeBanner: false,
          home: RepositoryProvider.value(
            value: repository,
            child: MainPage(),
          ),
        );
}

class MainPage extends StatelessWidget {
  final _appRouter = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      theme: getAppTheme(),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
