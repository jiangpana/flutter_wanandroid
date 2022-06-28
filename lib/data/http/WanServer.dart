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

const successCode = 0;

class WanAndroidServer {
  late BaseViewModel state;

  WanAndroidServer(this.state);

  late final DioProxy _dioProxy = DioProxy(this);

  setHttpRequestState(HttpRequestState state, {String? message}){
    this.state.setHttpRequestState(state, message: message);
  }

  Future<List<NaviEntity>?> getNavi() async {
    return  _dioProxy.get<List<NaviEntity>>(WanUrls.NAVI);
  }

  Future<ArticleListEntity?> getArticleList({page}) async {
    return  _dioProxy
        .get<ArticleListEntity>("${WanUrls.ARTICLE_LIST}$page/json");
  }

  Future<CollectEntity?> getCollectedArticle({page}) async {
    return _dioProxy
        .get<CollectEntity>("${WanUrls.COLLECTED_ARTICLE}$page/json");
  }

  Future<WendaEntity?> getWenda({page}) async {
    return _dioProxy.get<WendaEntity>("${WanUrls.WENDA_LIST}$page/json");
  }

  Future<UserEntity?> login({username, password}) async {
    return _dioProxy.post(WanUrls.LOGIN, queryParameters: {
      "username": username,
      "password": password,
    });
  }


  Future<String?> logout() async {
    return _dioProxy.get(WanUrls.LOGOUT);
  }

  Future<UserEntity?> register({username, password}) async {
    return _dioProxy.post(WanUrls.REGISTER, queryParameters: {
      "username": username,
      "password": password,
      "repassword": password,
    });
  }

}
