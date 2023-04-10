import 'package:dio/dio.dart';

class PufferError extends Error {
  DioError? error;
  String code;
  String msg;

  PufferError({this.error, required this.code, required this.msg});
}
