import 'package:dio/dio.dart';
import 'package:flutter_wanandroid/generated/json/base/json_convert_content.dart';
import '../base/state/BaseState.dart';
import '../base/vm/BaseViewModel.dart';
import '../data/WanRepository.dart';
import 'DioProxy.dart';
import 'base/base_entity.dart';

const successCode = 0;

class WanAndroidService {
  late BaseViewModel state;
  late WanRepository repository = WanRepository();

  WanAndroidService(this.state) {}

  late final DioProxy _dioProxy = DioProxy();

  Future<T?> httpGet<T>(String path,
      {Map<String, dynamic>? queryParameters,
      Options? options,
      CancelToken? cancelToken,
      ProgressCallback? onReceiveProgress}) async {
    state.setHttpRequestState(HttpRequestState.Loading);
    try {
      var response = await _dioProxy.dio.get(
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
      var response = await _dioProxy.dio.get(
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
      var response = await _dioProxy.dio.post(
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
    if (entity.errorCode == successCode) {
      state.setHttpRequestState(HttpRequestState.Suc);
      repository.sp.put(path, entity.data.toString());
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
    if (entity.errorCode == successCode) {
      state.setHttpRequestState(HttpRequestState.Suc);
      repository.sp.put(path, entity.data.toString());
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
