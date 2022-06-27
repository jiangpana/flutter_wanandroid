import 'package:dio/dio.dart';
import '../../base/state/BaseState.dart';
import '../../base/vm/BaseViewModel.dart';
import '../WanRepository.dart';
import '../entity/article_list_entity.dart';
import '../entity/collect_entity.dart';
import '../entity/navi_entity.dart';
import '../entity/user_entity.dart';
import '../entity/wenda_entity.dart';
import 'DioProxy.dart';
import 'WanUrls.dart';
import 'base/base_entity.dart';

const successCode = 0;

class WanAndroidServer {
  late BaseViewModel state;

  WanAndroidServer(this.state);

  late Dio dio = Dio();

  late final DioProxy _dioProxy = DioProxy();

  Future<List<NaviEntity>?> getNavi() async {
    return _dioProxy.getList<NaviEntity>(WanUrls.NAVI);
  }

  Future<ArticleListEntity?> getHomeList({page}) async {
    return _dioProxy.get<ArticleListEntity>("${WanUrls.HOME_LIST}$page/json");
  }

  Future<CollectEntity?> getCollectedArticle({page}) async {
    return _dioProxy
        .get<CollectEntity>("${WanUrls.COLLECTED_ARTICLE}$page/json");
  }

  Future<WendaEntity?> getWenda({page}) async {
    return _dioProxy.get<WendaEntity>("${WanUrls.WENDA}$page/json");
  }

  Future<UserEntity?> login({username, password}) async {
    return processResponse<UserEntity>(
        await dio.post(WanUrls.LOGIN, queryParameters: {
          "username": username,
          "password": password,
        }),
        WanUrls.LOGIN);
  }

  Future<UserEntity?> register({username, password}) async {
    return _dioProxy.post(WanUrls.REGISTER, queryParameters: {
      "username": username,
      "password": password,
      "repassword": password,
    });
  }

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

  List<T>? processListResponse<T>(Response<dynamic> rep, String path) {
    if (rep.statusCode != 200) {
      state.setHttpRequestState(HttpRequestState.Fail);
      return null;
    }
    var entity = BaseListEntity<T>.fromJson(rep.data);
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
