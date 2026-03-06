import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:rose_say/rsCommon/index.dart';

class RSHeaderInterceptor extends Interceptor {
  // Generate request ID
  String _generateRequestId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }

  final Connectivity _connectivity = Connectivity();

  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final connectivityResult = await _connectivity.checkConnectivity();
    if (connectivityResult.contains(ConnectivityResult.none)) {
      handler.reject(
        DioException(
          requestOptions: options,
          error: 'Network connection unavailable',
          type: DioExceptionType.unknown,
        ),
      );
      return;
    }

    // Add authentication token (if available)
    if (RSDioClient.instance.token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer ${RSDioClient.instance.token}';
    }

    // Add request ID for tracking
    options.headers['X-Request-ID'] = _generateRequestId();

    if (RSDioClient.instance.enableLog) {
      RSDioClient.instance.logger.d(
        'Request send: ${options.method} ${options.baseUrl} ${options.path}\nRequest headers: ${options.headers}\nRequest body: ${options.data}',
      );
    }
    super.onRequest(options, handler);
  }
}
