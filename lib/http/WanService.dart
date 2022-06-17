import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';
import '../base/BaseState.dart';
import '../base/BaseViewModel.dart';
import '../data/LocalRepository.dart';
import 'HttpDio.dart';
import 'base/base_entity.dart';

const SUC_CODE = 0;

class WanAndroidService {
  late BaseViewModel state;
  late LocalRepository repository = LocalRepository();

  WanAndroidService(this.state) {}

  late HttpDio httpDio = HttpDio();

  Future<T?> httpGet<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    state.setHttpRequestState(HttpRequestState.Loading);
    try {
      var response = await httpDio.instance.get(
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

  Future<List<T>?> httpListGet<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    state.setHttpRequestState(HttpRequestState.Loading);
    try {
      var response = await httpDio.instance.get(
        path,
        queryParameters: queryParameters,
        options: options,
        cancelToken: cancelToken,
        onReceiveProgress: onReceiveProgress,
      );
      if (response.statusCode == 200) {
        return processListResponse<T>(response, path);
      } else {
        state.setHttpRequestState(HttpRequestState.Fail);
        return null;
      }
    } catch (e) {
      print(e);
      state.setHttpRequestState(HttpRequestState.Fail);
      return null;
    }
  }

  Future<T?> httpPost<T>(String path,
      {queryParameters, options, data, cancelToken, onReceiveProgress}) async {
    state.setHttpRequestState(HttpRequestState.Loading);
    try {
      var response = await httpDio.instance.post(
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
    var entity = BaseEntity<T>.fromJson(rep.data);
    print("entity = $entity");
    if (entity.errorCode == SUC_CODE) {
      state.setHttpRequestState(HttpRequestState.Suc);
      repository.put(path, entity.data.toString());
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

  List<T>? processListResponse<T>(Response<dynamic> rep, String path) {
/*   var json = rep.data as Map<String, dynamic>;
    var entity = BaseListEntity<T>.fromJson(rep.data);
   var data =json['data'];
   return JsonConvert().convertListNotNull<T>(data);*/
    var entity = BaseListEntity<T>.fromJson(rep.data);
    if (entity.errorCode == SUC_CODE) {
      state.setHttpRequestState(HttpRequestState.Suc);
      repository.put(path, entity.data.toString());
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
