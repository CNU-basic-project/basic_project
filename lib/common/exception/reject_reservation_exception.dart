class RejectReservationException implements Exception {
  String message;
  RejectReservationException(this.message);

  @override
  String toString() {
    return message;
  }
}