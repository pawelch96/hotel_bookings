abstract class DomainException implements Exception {
  DomainException(this.message, {this.cause});

  final String message;
  final Object? cause;

  @override
  String toString() => '$runtimeType: $message';
}

class NetworkException extends DomainException {
  NetworkException(super.message, {super.cause});
}

class UnknownDomainException extends DomainException {
  UnknownDomainException(super.message, {super.cause});
}
