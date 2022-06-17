import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/LocalRepository.dart';
import '../http/WanService.dart';
import 'BaseState.dart';

class BaseViewModel<T> extends StateNotifier<T> {
  BaseViewModel(super.state);
  late LocalRepository repository =LocalRepository();

  late final HttpState _httpState = HttpState();

  late final ChangeNotifierProvider<HttpState> _httpStateProvider =
      ChangeNotifierProvider((_) => _httpState);

  ChangeNotifierProvider<HttpState> getStateProvider() => _httpStateProvider;

  late WanAndroidService service = WanAndroidService(this);


  setHttpRequestState(HttpRequestState state,{String? message}) {
    _httpState.setHttpRequestState(state,message:message);
  }
}
