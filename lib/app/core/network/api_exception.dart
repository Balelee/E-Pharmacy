class ApiException implements Exception {
  final String? message;
  final String? prefix;
  final String? url;

  ApiException([this.message, this.prefix, this.url]);
}

class FetchDataException extends ApiException {
  FetchDataException([String? message, String? url])
      : super(message, 'Unable to process', url);
}

class ApiNotRespondingException extends ApiException {
  ApiNotRespondingException([String? message, String? url])
      : super(message, 'Api not responded in time', url);
}
