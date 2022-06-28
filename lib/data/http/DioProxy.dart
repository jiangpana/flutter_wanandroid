import 'package:dio/dio.dart';

import '../../base/state/BaseState.dart';
import '../WanRepository.dart';
import '../entity/base_entity.dart';
import 'CookieManager.dart';
import 'WanServer.dart';

const successCode = 0;

class DioHolder {

  late final Dio _dio = Dio();

  static get() => DioHolder()._dio;

  DioHolder._() {
    _dio.interceptors.add(CookieManager.instance);
  }

  static DioHolder? _dioHolder;

  factory DioHolder() {
    return _dioHolder ??= DioHolder._();
  }
}

class DioProxy {
  late WanAndroidServer state;

  late Dio dio = DioHolder.get();

  DioProxy(this.state) {}

  addGlobalHeaders(map) {
    dio.options.headers.addAll(map);
  }

  addGlobalHeader(key, value) {
    dio.options.headers.addAll({key: value});
  }

  addInterceptor(interceptor) {
    dio.interceptors.add(interceptor);
  }

  Future<T?> get<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    state.setHttpRequestState(HttpRequestState.Loading);
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
        state.setHttpRequestState(HttpRequestState.Fail);
        return null;
      }
    } catch (e) {
      state.setHttpRequestState(HttpRequestState.Fail);
      return null;
    }
  }

  Future<T?> post<T>(String path,
      {queryParameters, options, data, cancelToken, onReceiveProgress}) async {
    state.setHttpRequestState(HttpRequestState.Loading);
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
        state.setHttpRequestState(HttpRequestState.Fail);
        return null;
      }
    } catch (e) {
      state.setHttpRequestState(HttpRequestState.Fail);
      return null;
    }
  }

  T? processResponse<T>(Response<dynamic> rep, String path) {
    if (rep.statusCode != 200) {
      state.setHttpRequestState(HttpRequestState.Fail);
      return null;
    }
    var entity = BaseEntity<T>.fromJson(rep.data);
    if (entity.errorCode == successCode) {
      state.setHttpRequestState(HttpRequestState.Suc);
      WanRepository.sp.put(path, entity.data.toString());
    } else {
      state.setHttpRequestState(HttpRequestState.Fail,
          message: entity.errorMsg!);
    }
    try {
      return entity.data;
    } catch (e) {
      return null;
    }
  }
}
