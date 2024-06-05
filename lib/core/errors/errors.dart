import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/services.dart';

class MessageException implements Exception {
  final String message;
  const MessageException({required this.message}) : super();
}

MessageException getErrorMessage(Object? error) {
  var msg = "";
  if (error is DioException) {
    msg = error.message ?? "";
  } else if (error is SocketException) {
    msg = error.message;
  } else if (error is HttpException) {
    msg = error.message;
  } else if (error is FormatException) {
    msg = error.message;
  } else if (error is TimeoutException) {
    msg = error.message ?? "";
  } else if (error is PlatformException) {
    msg = error.details ?? "";
  } else {
    msg = error.toString();
  }
  return MessageException(message: msg);
}
