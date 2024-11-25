/*
import 'dart:convert';
import 'package:app/app.dart';
import 'package:dio/dio.dart';

class TokenInterceptor extends Interceptor {
  final StorageService _storageService;

  TokenInterceptor({required StorageService storageService}):_storageService=storageService;

  final protectedRoutes = [
    'auth/quote',
  ];


  final unprotectedRoutes = [
    '/auth/login',
  ];

  bool _isUnprotectedRoute(String path) {
    return unprotectedRoutes.any((route) => path.contains(route));
  }


  @override
  Future<void> onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (_isUnprotectedRoute(options.path)) {
      // Bypass adding the token for unprotected requests
      return handler.next(options);
    }
    final userModelJSON=  await
    _storageService.readData(StorageConstants.userDataKey);
    if(userModelJSON == null)
    {
      return handler.next(options);
    }

    final String token= UserModel.fromJson(jsonDecode(userModelJSON)).accessToken;

    options.headers['Authorization'] = 'Bearer $token';
    // Continue with the request
    return handler.next(options);
  }

}*/
