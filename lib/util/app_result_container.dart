sealed class AppResult<S, E extends Exception> {
  const AppResult();
}

final class AppSuccess<S, E extends Exception> extends AppResult<S, E> {
  const AppSuccess(this.value);
  final S value;
}

final class AppFailure<S, E extends Exception> extends AppResult<S, E> {
  const AppFailure(this.exception);
  final E exception;
}
