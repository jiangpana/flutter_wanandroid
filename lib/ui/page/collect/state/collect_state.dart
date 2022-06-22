
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../data/entity/collect_entity.dart';


part 'collect_state.freezed.dart';

@freezed
class CollectPageState with _$CollectPageState{
factory CollectPageState({ @Default([]) List<CollectDatas> datas  , CollectEntity? collectEntity}) = _CollectPageState;

}