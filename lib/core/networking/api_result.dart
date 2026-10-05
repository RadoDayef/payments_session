abstract class ApiResult<T> {}

final class ApiSuccess<T> extends ApiResult<T> {
  T data;

  ApiSuccess(this.data);
}

final class ApiFailure<T> extends ApiResult<T> {
  String message;

  ApiFailure(this.message);
}
