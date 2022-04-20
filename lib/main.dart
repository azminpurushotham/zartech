import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zartech/simple_bloc_observer.dart';

import 'app.dart';
import 'home/repository.dart';

void main() {
  BlocOverrides.runZoned(
    () => runApp(App(repository: Repository())),
    blocObserver: SimpleBlocObserver(),
  );
}
