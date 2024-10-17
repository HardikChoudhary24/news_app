enum NetworkException {
  noInternetException(
      statusCode: null, message: "You are not connected to the internet."),
  unauthorisedException(
      statusCode: 401,
      message:
          "Your authentication credentials are invalid. Please log in to continue."),
  badRequestException(statusCode: 400, message: "Something went wrong!"),
  notFoundException(statusCode: 404, message: "Page not found!"),
  internalServerException(statusCode: 500, message: "Something went wrong!"),
  generalException(statusCode: null, message: "Something went wrong!"),
  networkTimeoutException(statusCode: null, message: "Connection timed out!");

  final int? statusCode;
  final String message;

  const NetworkException({this.statusCode, required this.message});
}

class Exceptions implements Exception {
  NetworkException exception;

  Exceptions(this.exception);

  @override
  String toString() {
    return exception.message;
  }
}
