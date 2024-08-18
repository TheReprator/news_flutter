import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:injectable/injectable.dart';
import 'package:news_flutter/app/routes/go_router_init.dart';
import 'package:news_flutter/util/logger.dart';

@injectable
class MainApplication extends StatefulWidget {
  final Logger _logger;
  const MainApplication(this._logger, {super.key});

  @override
  _MainApplicationState createState() => _MainApplicationState(_logger);
}

class _MainApplicationState extends State<MainApplication> {
  late final AppLifecycleListener _listener;
  late AppLifecycleState? _state;

  final Logger _logger;

  _MainApplicationState(this._logger);

  bool canPopDialog = false;

  @override
  void initState() {
    super.initState();
    _state = SchedulerBinding.instance.lifecycleState;
    _listener = AppLifecycleListener(
      onDetach: _onDetach,
      onHide: _onHide,
      onInactive: _onInactive,
      onPause: _onPause,
      onRestart: _onRestart,
      onResume: _onResume,
      onShow: _onShow,
      onStateChange: _onStateChanged,
      // Handle the onExitRequested callback
      onExitRequested: _onExitRequested,
    );
  }

  @override
  void dispose() {
    _listener.dispose();
    super.dispose();
  }

  Future<AppExitResponse> _onExitRequested() async {
    throw Exception('Exit App');
  }

  void _onDetach() => _logger.error('_onDetach');

  void _onHide() => _logger.error('_onHide');

  void _onInactive() => _logger.error('_onInactive');

  void _onPause() => _logger.error('_onPause');

  void _onRestart() => _logger.error('_onRestart');

  void _onResume() => _logger.error('_onResume');

  void _onShow() => _logger.error('_onShow');

  void _onStateChanged(AppLifecycleState state) {
    // Track state changes
    _logger.error('new state is: $state');
    _state = state;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'News',
      routerConfig: routerinit,
    );
  }
}
