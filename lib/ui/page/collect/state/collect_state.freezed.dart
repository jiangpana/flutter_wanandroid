// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'collect_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$CollectPageState {
  List<CollectDatas> get datas => throw _privateConstructorUsedError;
  CollectEntity? get collectEntity => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $CollectPageStateCopyWith<CollectPageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectPageStateCopyWith<$Res> {
  factory $CollectPageStateCopyWith(
          CollectPageState value, $Res Function(CollectPageState) then) =
      _$CollectPageStateCopyWithImpl<$Res>;
  $Res call({List<CollectDatas> datas, CollectEntity? collectEntity});
}

/// @nodoc
class _$CollectPageStateCopyWithImpl<$Res>
    implements $CollectPageStateCopyWith<$Res> {
  _$CollectPageStateCopyWithImpl(this._value, this._then);

  final CollectPageState _value;
  // ignore: unused_field
  final $Res Function(CollectPageState) _then;

  @override
  $Res call({
    Object? datas = freezed,
    Object? collectEntity = freezed,
  }) {
    return _then(_value.copyWith(
      datas: datas == freezed
          ? _value.datas
          : datas // ignore: cast_nullable_to_non_nullable
              as List<CollectDatas>,
      collectEntity: collectEntity == freezed
          ? _value.collectEntity
          : collectEntity // ignore: cast_nullable_to_non_nullable
              as CollectEntity?,
    ));
  }
}

/// @nodoc
abstract class _$$_CollectPageStateCopyWith<$Res>
    implements $CollectPageStateCopyWith<$Res> {
  factory _$$_CollectPageStateCopyWith(
          _$_CollectPageState value, $Res Function(_$_CollectPageState) then) =
      __$$_CollectPageStateCopyWithImpl<$Res>;
  @override
  $Res call({List<CollectDatas> datas, CollectEntity? collectEntity});
}

/// @nodoc
class __$$_CollectPageStateCopyWithImpl<$Res>
    extends _$CollectPageStateCopyWithImpl<$Res>
    implements _$$_CollectPageStateCopyWith<$Res> {
  __$$_CollectPageStateCopyWithImpl(
      _$_CollectPageState _value, $Res Function(_$_CollectPageState) _then)
      : super(_value, (v) => _then(v as _$_CollectPageState));

  @override
  _$_CollectPageState get _value => super._value as _$_CollectPageState;

  @override
  $Res call({
    Object? datas = freezed,
    Object? collectEntity = freezed,
  }) {
    return _then(_$_CollectPageState(
      datas: datas == freezed
          ? _value._datas
          : datas // ignore: cast_nullable_to_non_nullable
              as List<CollectDatas>,
      collectEntity: collectEntity == freezed
          ? _value.collectEntity
          : collectEntity // ignore: cast_nullable_to_non_nullable
              as CollectEntity?,
    ));
  }
}

/// @nodoc

class _$_CollectPageState implements _CollectPageState {
  _$_CollectPageState(
      {final List<CollectDatas> datas = const [], this.collectEntity})
      : _datas = datas;

  final List<CollectDatas> _datas;
  @override
  @JsonKey()
  List<CollectDatas> get datas {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_datas);
  }

  @override
  final CollectEntity? collectEntity;

  @override
  String toString() {
    return 'CollectPageState(datas: $datas, collectEntity: $collectEntity)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CollectPageState &&
            const DeepCollectionEquality().equals(other._datas, _datas) &&
            const DeepCollectionEquality()
                .equals(other.collectEntity, collectEntity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_datas),
      const DeepCollectionEquality().hash(collectEntity));

  @JsonKey(ignore: true)
  @override
  _$$_CollectPageStateCopyWith<_$_CollectPageState> get copyWith =>
      __$$_CollectPageStateCopyWithImpl<_$_CollectPageState>(this, _$identity);
}

abstract class _CollectPageState implements CollectPageState {
  factory _CollectPageState(
      {final List<CollectDatas> datas,
      final CollectEntity? collectEntity}) = _$_CollectPageState;

  @override
  List<CollectDatas> get datas => throw _privateConstructorUsedError;
  @override
  CollectEntity? get collectEntity => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_CollectPageStateCopyWith<_$_CollectPageState> get copyWith =>
      throw _privateConstructorUsedError;
}
