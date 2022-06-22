import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_wanandroid/ui/page/home/Home.dart';

import '../../data/LocalRepository.dart';
import '../../http/WanService.dart';
import '../BaseState.dart';

abstract class BaseViewModel {
  BaseViewModel();

  late final LocalRepository repository = LocalRepository();
  late final WanAndroidService service = WanAndroidService(this);
  late final HttpState _httpState = HttpState();

  get httpState=>_httpState;

  late final  _httpStateProvider =ChangeNotifierProvider((_) => _httpState);

  HttpState getHttpState(WidgetRef ref) =>
      ref.watch(_httpStateProvider);


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
