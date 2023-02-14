class AppExceptions implements Exception {
  String prefix;
  String message;

  AppExceptions(this.message, this.prefix);

  String toString() {
    return '$prefix $message';
  }
}

class FetchDataException extends AppExceptions {
  FetchDataException([String? message])
      : super(message!, 'Error During Communication: ');
}

class BadRequestException extends AppExceptions {
  BadRequestException([String? message])
      : super(message!, 'Invalid Request: ');
}

class UnauthorizedException extends AppExceptions {
  UnauthorizedException([String? message])
      : super(message!, 'Unautorized Request: ');
}

class InvalidInputException extends AppExceptions {
  InvalidInputException([String? message])
      : super(message!, 'Invalid Input: ');
}

