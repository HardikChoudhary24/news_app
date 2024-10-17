import 'package:junglee_news/services/response/status.dart';

class Response<T> {
  Status? status;
  T? data;
  String? exception;

  Response(this.status, this.data, this.exception);

  Response.success(this.data) : status = Status.success;

  Response.loading() : status = Status.loading;

  Response.error(this.exception) : status = Status.error;

  @override
  String toString() {
    return "Status: $status \n Message: $exception \n Data: $data";
  }
}
