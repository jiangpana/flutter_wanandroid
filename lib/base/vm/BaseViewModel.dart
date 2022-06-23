import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/data/WanRepository.dart';

import '../../http/WanService.dart';
import '../state/BaseState.dart';

abstract class BaseViewModel {
  BaseViewModel();

  late final WanRepository repository = WanRepository();
  late final WanAndroidService service = WanAndroidService(this);
  late final HttpState _httpState = HttpState();

  get httpState=>_httpState;

  late final  _httpStateProvider =ChangeNotifierProvider((_) => _httpState);

  HttpState watchHttpState(WidgetRef ref) =>
      ref.watch(_httpStateProvider);

  setHttpRequestState(HttpRequestState state, {String? message}) {
    _httpState.setHttpRequestState(state, message: message);
  }

}


class IStateNotifier<S> extends StateNotifier<S> {
  IStateNotifier(S s) : super(s);
  late WidgetRef ref;
  late final provider =
      StateNotifierProvider<IStateNotifier<S>, S>((ref) => this);

  S watch(WidgetRef ref) {
    this.ref = ref;
    return ref.watch(provider);
  }
}

IStateNotifier<S> newNotifier<S>(S s) {
  return IStateNotifier(s);
}
