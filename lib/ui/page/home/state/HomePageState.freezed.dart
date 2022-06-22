// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'HomePageState.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$HomePageState {
  List<ArticleListDatas> get datas => throw _privateConstructorUsedError;
  ArticleListEntity? get articleListEntity =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $HomePageStateCopyWith<HomePageState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $HomePageStateCopyWith<$Res> {
  factory $HomePageStateCopyWith(
          HomePageState value, $Res Function(HomePageState) then) =
      _$HomePageStateCopyWithImpl<$Res>;
  $Res call(
      {List<ArticleListDatas> datas, ArticleListEntity? articleListEntity});
}

/// @nodoc
class _$HomePageStateCopyWithImpl<$Res>
    implements $HomePageStateCopyWith<$Res> {
  _$HomePageStateCopyWithImpl(this._value, this._then);

  final HomePageState _value;
  // ignore: unused_field
  final $Res Function(HomePageState) _then;

  @override
  $Res call({
    Object? datas = freezed,
    Object? articleListEntity = freezed,
  }) {
    return _then(_value.copyWith(
      datas: datas == freezed
          ? _value.datas
          : datas // ignore: cast_nullable_to_non_nullable
              as List<ArticleListDatas>,
      articleListEntity: articleListEntity == freezed
          ? _value.articleListEntity
          : articleListEntity // ignore: cast_nullable_to_non_nullable
              as ArticleListEntity?,
    ));
  }
}

/// @nodoc
abstract class _$$_HomePageStateCopyWith<$Res>
    implements $HomePageStateCopyWith<$Res> {
  factory _$$_HomePageStateCopyWith(
          _$_HomePageState value, $Res Function(_$_HomePageState) then) =
      __$$_HomePageStateCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<ArticleListDatas> datas, ArticleListEntity? articleListEntity});
}

/// @nodoc
class __$$_HomePageStateCopyWithImpl<$Res>
    extends _$HomePageStateCopyWithImpl<$Res>
    implements _$$_HomePageStateCopyWith<$Res> {
  __$$_HomePageStateCopyWithImpl(
      _$_HomePageState _value, $Res Function(_$_HomePageState) _then)
      : super(_value, (v) => _then(v as _$_HomePageState));

  @override
  _$_HomePageState get _value => super._value as _$_HomePageState;

  @override
  $Res call({
    Object? datas = freezed,
    Object? articleListEntity = freezed,
  }) {
    return _then(_$_HomePageState(
      datas: datas == freezed
          ? _value._datas
          : datas // ignore: cast_nullable_to_non_nullable
              as List<ArticleListDatas>,
      articleListEntity: articleListEntity == freezed
          ? _value.articleListEntity
          : articleListEntity // ignore: cast_nullable_to_non_nullable
              as ArticleListEntity?,
    ));
  }
}

/// @nodoc

class _$_HomePageState with DiagnosticableTreeMixin implements _HomePageState {
  _$_HomePageState(
      {final List<ArticleListDatas> datas = const [], this.articleListEntity})
      : _datas = datas;

  final List<ArticleListDatas> _datas;
  @override
  @JsonKey()
  List<ArticleListDatas> get datas {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_datas);
  }

  @override
  final ArticleListEntity? articleListEntity;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'HomePageState(datas: $datas, articleListEntity: $articleListEntity)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'HomePageState'))
      ..add(DiagnosticsProperty('datas', datas))
      ..add(DiagnosticsProperty('articleListEntity', articleListEntity));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_HomePageState &&
            const DeepCollectionEquality().equals(other._datas, _datas) &&
            const DeepCollectionEquality()
                .equals(other.articleListEntity, articleListEntity));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_datas),
      const DeepCollectionEquality().hash(articleListEntity));

  @JsonKey(ignore: true)
  @override
  _$$_HomePageStateCopyWith<_$_HomePageState> get copyWith =>
      __$$_HomePageStateCopyWithImpl<_$_HomePageState>(this, _$identity);
}

abstract class _HomePageState implements HomePageState {
  factory _HomePageState(
      {final List<ArticleListDatas> datas,
      final ArticleListEntity? articleListEntity}) = _$_HomePageState;

  @override
  List<ArticleListDatas> get datas => throw _privateConstructorUsedError;
  @override
  ArticleListEntity? get articleListEntity =>
      throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$$_HomePageStateCopyWith<_$_HomePageState> get copyWith =>
      throw _privateConstructorUsedError;
}
