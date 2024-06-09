class AIException implements Exception {
  String message;
  AIException(this.message);

  @override
  String toString() {
    return message;
  }
}