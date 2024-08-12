import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:news_flutter/util/logger.dart';

@injectable
class AppBlocObserver extends BlocObserver {
  AppBlocObserver(this._logger);

  final Logger _logger;

  @override
  void onTransition(
    Bloc<Object?, Object?> bloc,
    Transition<Object?, Object?> transition,
  ) {
    final buffer = StringBuffer()
      ..write('Bloc: ${bloc.runtimeType} | ')
      ..writeln('${transition.event.runtimeType}')
      ..write('Transition: ${transition.currentState.runtimeType}')
      ..writeln(' => ${transition.nextState.runtimeType}')
      ..write('New State: ${transition.nextState}');
    _logger.info(buffer.toString());
    super.onTransition(bloc, transition);
  }

  @override
  void onEvent(Bloc<Object?, Object?> bloc, Object? event) {
    final buffer = StringBuffer()
      ..writeln('On Event :')
      ..writeln('Bloc: ${bloc.runtimeType}')
      ..write('Event: ${event.toString()}');
    _logger.info(buffer.toString());
    super.onEvent(bloc, event);
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    _logger.info(
      'Bloc: ${bloc.runtimeType} | ${change.currentState} | ${change.nextState}',
    );
    super.onChange(bloc, change);
  }

  @override
  void onCreate(BlocBase<dynamic> bloc) {
    _logger.info('Bloc Created | ${bloc.runtimeType} ');
    super.onCreate(bloc);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    _logger.info('Bloc onClose | ${bloc.runtimeType} ');
    super.onClose(bloc);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    _logger.error(
      'Bloc onError: ${bloc.runtimeType} | $error',
      error: error,
      stackTrace: stackTrace,
    );
    super.onError(bloc, error, stackTrace);
  }
}
