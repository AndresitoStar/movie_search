class ApiException implements Exception {
  final dynamic message;

  ApiException([this.message]);

  String toString() {
    Object? message = this.message;
    if (message == null) return ">>> ApiException";
    return ">>>>ApiException: $message";
  }
}
