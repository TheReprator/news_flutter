import 'package:freezed_annotation/freezed_annotation.dart';

part 'app_result_container.freezed.dart';

@freezed
sealed class AppResult<T> with _$AppResult<T> {
  const factory AppResult.success(T data) = AppSuccess;
  const factory AppResult.error(String message) = AppFailure;
}
