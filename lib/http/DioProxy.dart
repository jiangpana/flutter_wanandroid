import 'package:dio/dio.dart';
import '../data/WanRepository.dart';

import 'CookieManager.dart';
import 'base/base_entity.dart';



const successCode = 0;


class DioProxy {

  late WanRepository repository = WanRepository();


  late Dio dio = Dio();

  DioProxy._() {
    dio.interceptors.add(TokenInterceptor());
    dio.interceptors.add(CookieManager.instance);
  }

  static DioProxy? _instance;

  factory DioProxy() {
    _instance??=DioProxy._();
    return _instance!;
  }

  addGlobalHeaders(map) {
    dio.options.headers.addAll(map);
  }

  addGlobalHeader(key, value) {
    dio.options.headers.addAll({key: value});
  }

  addInterceptor(interceptor) {
    dio.interceptors.add(interceptor);
  }

  Future<T?> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
    Options? options,
    CancelToken? cancelToken,
    ProgressCallback? onReceiveProgress,
    Function? start,
    Function? fail,
  }) async {
    try {
      var response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return processResponse<T>(response, path)!;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<T>?> getList<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    try {
      var response = await dio.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return processListResponse<T>(response, path);
      } else {
        return null;
      }
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<T?> post<T>(String path,
      {queryParameters, options, data, cancelToken, onReceiveProgress}) async {
    try {
      var response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return processResponse<T>(response, path)!;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<List<T>?> postList<T>(String path,
      {queryParameters, options, data, cancelToken, onReceiveProgress}) async {
    try {
      var response = await dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return processListResponse<T>(response, path)!;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  T? processResponse<T>(Response<dynamic> rep, String path) {
    var entity = BaseEntity<T>.fromJson(rep.data);
    print("entity = $entity");
    if (entity.errorCode == successCode) {
      repository.sp.put(path, entity.data.toString());
    }
    try {
      return entity.data;
    } catch (e) {
      return null;
    }
  }

  List<T>? processListResponse<T>(Response<dynamic> rep, String path) {
    var entity = BaseListEntity<T>.fromJson(rep.data);
    if (entity.errorCode == successCode) {
      repository.sp.put(path, entity.data.toString());
    }
    try {
      return entity.data;
    } catch (e) {
      return null;
    }
  }
}

class TokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    ///token from cache
    // var token = Cache.getToken();
    // options.headers["Authorization"] = "Basic $token";
    print(options.uri);
    super.onRequest(options, handler);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
  }
}
