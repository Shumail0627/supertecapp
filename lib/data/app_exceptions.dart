// ignore_for_file: prefer_typing_uninitialized_variables

class AppException implements Exception {
  final _message;
  final _prefix;

  AppException([this._message, this._prefix]);

  @override
  String toString() {
    return '$_prefix$_message';
  }
}

class InternetException extends AppException {
  InternetException([String? message]) : super('', 'No internet ');
}

class RequestTimeOut extends AppException {
  RequestTimeOut([String? message]) : super(message, 'Request Time Out');
}

class ServerException extends AppException {
  ServerException([String? message]) : super(message, 'Internel Server Error');
}

class InvalidUrlException extends AppException {
  InvalidUrlException([String? message]) : super(message, 'Invalid url');
}
