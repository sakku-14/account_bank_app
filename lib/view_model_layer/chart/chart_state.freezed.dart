// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'chart_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ChartState {
  Box<Transaction> get transactionsBox => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ChartStateCopyWith<ChartState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChartStateCopyWith<$Res> {
  factory $ChartStateCopyWith(
          ChartState value, $Res Function(ChartState) then) =
      _$ChartStateCopyWithImpl<$Res, ChartState>;
  @useResult
  $Res call({Box<Transaction> transactionsBox});
}

/// @nodoc
class _$ChartStateCopyWithImpl<$Res, $Val extends ChartState>
    implements $ChartStateCopyWith<$Res> {
  _$ChartStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionsBox = null,
  }) {
    return _then(_value.copyWith(
      transactionsBox: null == transactionsBox
          ? _value.transactionsBox
          : transactionsBox // ignore: cast_nullable_to_non_nullable
              as Box<Transaction>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChartStateCopyWith<$Res>
    implements $ChartStateCopyWith<$Res> {
  factory _$$_ChartStateCopyWith(
          _$_ChartState value, $Res Function(_$_ChartState) then) =
      __$$_ChartStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Box<Transaction> transactionsBox});
}

/// @nodoc
class __$$_ChartStateCopyWithImpl<$Res>
    extends _$ChartStateCopyWithImpl<$Res, _$_ChartState>
    implements _$$_ChartStateCopyWith<$Res> {
  __$$_ChartStateCopyWithImpl(
      _$_ChartState _value, $Res Function(_$_ChartState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionsBox = null,
  }) {
    return _then(_$_ChartState(
      transactionsBox: null == transactionsBox
          ? _value.transactionsBox
          : transactionsBox // ignore: cast_nullable_to_non_nullable
              as Box<Transaction>,
    ));
  }
}

/// @nodoc

class _$_ChartState with DiagnosticableTreeMixin implements _ChartState {
  const _$_ChartState({required this.transactionsBox});

  @override
  final Box<Transaction> transactionsBox;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'ChartState(transactionsBox: $transactionsBox)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'ChartState'))
      ..add(DiagnosticsProperty('transactionsBox', transactionsBox));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChartState &&
            (identical(other.transactionsBox, transactionsBox) ||
                other.transactionsBox == transactionsBox));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transactionsBox);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChartStateCopyWith<_$_ChartState> get copyWith =>
      __$$_ChartStateCopyWithImpl<_$_ChartState>(this, _$identity);
}

abstract class _ChartState implements ChartState {
  const factory _ChartState({required final Box<Transaction> transactionsBox}) =
      _$_ChartState;

  @override
  Box<Transaction> get transactionsBox;
  @override
  @JsonKey(ignore: true)
  _$$_ChartStateCopyWith<_$_ChartState> get copyWith =>
      throw _privateConstructorUsedError;
}
