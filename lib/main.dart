import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/app/root_application.dart';
import 'package:news_flutter/di/di.dart';
import 'package:news_flutter/util/logger.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    configureDependencies();

    Bloc.observer = getIt.get<BlocObserver>();

    final logger = getIt.get<Logger>();
    logger.runLogging(
        () => runZonedGuarded(
              () {},
              logger.logZoneError,
            ),
        const LogOptions());

    runApp(MainApplication(logger));

    FlutterError.onError = (FlutterErrorDetails details) {
      FlutterError.presentError(details);
    };

    ErrorWidget.builder = (FlutterErrorDetails details) {
      return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: const Text('An global error occurred'),
        ),
        body: Center(
          child: Text(details.toString()),
        ),
      );
    };
  }, (Object error, StackTrace stack) {
    debugPrint(error.toString());
  });
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:news_flutter/app/root_application.dart';
// import 'package:news_flutter/di/di.dart';
// import 'package:news_flutter/util/logger.dart';
// import 'package:bloc_concurrency/bloc_concurrency.dart' as bloc_concurrency;

// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//   configureDependencies();
//   final logger = getIt.get<Logger>();

//   );
// }
