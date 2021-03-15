import 'dart:io';

import 'package:dio/dio.dart';
import 'package:stacked/stacked.dart';

class SafeAsyncExecutorImpl {
  /// Executes the [callable] async method and handles business exceptions
  /// thrown by the it.
  ///
  /// If the [callable] throws an exception that is not interest of the
  /// business logic then [onFailed] method is called passing the error.
  /// The [onFailed] must return a message that the application will show
  /// in a toast message.
  Future<void> execute(
      /* BuildContext context,  */ Future<void> Function() callable,
      {String Function(Exception error) onFailed,
      BaseViewModel viewModel}) async {
    try {
      await callable();
    } on DioError catch (e) {
      if (e.error is SocketException ||
          e.type == DioErrorType.connectTimeout ||
          e.type == DioErrorType.receiveTimeout ||
          e.type == DioErrorType.sendTimeout) {
        if (viewModel != null) {
          viewModel.setError(e);
        } else
          throw SocketException(null);
      }
    }
  }
}

/// This is an extension to the interface [SafeAsyncExecutor] that inserts
/// the method [safeExecute] to all implementations of the interface.
extension SafeAsyncExecutorExtension on SafeAsyncExecutor {
  /// Delegates the execution of [callable] async method
  /// to [SafeAsyncExecutorImpl].
  ///
  /// See [SafeAsyncExecutorImpl].
  Future<void> safeExecute(Future<void> Function() callable,
      {String Function(Exception error) onFailed, BaseViewModel viewModel}) {
    return SafeAsyncExecutorImpl().execute(callable, viewModel: viewModel);
  }
}

/// This is an interface that brings access to method [safeExecute] to those
/// who implements it.
///
/// See [SafeAsyncExecutorExtension].
abstract class SafeAsyncExecutor {}
