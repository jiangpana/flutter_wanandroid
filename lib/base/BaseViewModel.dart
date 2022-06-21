import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/ui/page/home/Home.dart';

import '../data/LocalRepository.dart';
import '../http/WanService.dart';
import 'BaseState.dart';

class BaseViewModel<T> extends StateNotifier<T> {
  BaseViewModel(super.state);

  late final LocalRepository repository = LocalRepository();
  late final WanAndroidService service = WanAndroidService(this);
  late final HttpState _httpState = HttpState();

  HttpState getHttpState(WidgetRef ref) =>
      ref.watch(ChangeNotifierProvider((_) => _httpState));

  T getPageState<V extends StateNotifier<T>>(WidgetRef ref, V vm) {
    var provider = StateNotifierProvider<V, T>((ref) => vm);
    return ref.watch(provider);
  }

  setHttpRequestState(HttpRequestState state, {String? message}) {
    _httpState.setHttpRequestState(state, message: message);
  }

  IStateNotifier<S> newNotifier<S>(S s) {
    return createStateNotifier<S>(s);
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

IStateNotifier<S> createStateNotifier<S>(S s) {
  return IStateNotifier(s);
}
