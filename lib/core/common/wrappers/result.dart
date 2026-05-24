class Result<T> {
  final T? data;
  final String? error;
  final bool success;

  Result.success(this.data) : success = true, error = null;
  Result.error(this.error) : success = false, data = null;
}
