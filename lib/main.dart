import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_flutter/app/root_application.dart';
import 'package:news_flutter/di/di.dart';
import 'package:news_flutter/util/logger.dart' as appLogger;

import 'package:logging/logging.dart';
import 'package:window_size/window_size.dart';

Future<void> main() async {
  runZonedGuarded<Future<void>>(() async {
    WidgetsFlutterBinding.ensureInitialized();

    _setupLogging();
    configureDependencies();

    Bloc.observer = getIt.get<BlocObserver>();

    final logger = getIt.get<appLogger.Logger>();
    logger.runLogging(
        () => runZonedGuarded(
              () {},
              logger.logZoneError,
            ),
        const appLogger.LogOptions());

    _setUpMinimumWindowSizeForDesktop();
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

void _setupLogging() {
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });
}

void _setUpMinimumWindowSizeForDesktop() {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    setWindowMinSize(const Size(450, 500));
  }
}
