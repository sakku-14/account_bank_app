// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'transaction_list_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$TransactionListState {
  ITransactionRepository get transactionRepository =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $TransactionListStateCopyWith<TransactionListState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TransactionListStateCopyWith<$Res> {
  factory $TransactionListStateCopyWith(TransactionListState value,
          $Res Function(TransactionListState) then) =
      _$TransactionListStateCopyWithImpl<$Res, TransactionListState>;
  @useResult
  $Res call({ITransactionRepository transactionRepository});
}

/// @nodoc
class _$TransactionListStateCopyWithImpl<$Res,
        $Val extends TransactionListState>
    implements $TransactionListStateCopyWith<$Res> {
  _$TransactionListStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionRepository = null,
  }) {
    return _then(_value.copyWith(
      transactionRepository: null == transactionRepository
          ? _value.transactionRepository
          : transactionRepository // ignore: cast_nullable_to_non_nullable
              as ITransactionRepository,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TransactionListStateCopyWith<$Res>
    implements $TransactionListStateCopyWith<$Res> {
  factory _$$_TransactionListStateCopyWith(_$_TransactionListState value,
          $Res Function(_$_TransactionListState) then) =
      __$$_TransactionListStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({ITransactionRepository transactionRepository});
}

/// @nodoc
class __$$_TransactionListStateCopyWithImpl<$Res>
    extends _$TransactionListStateCopyWithImpl<$Res, _$_TransactionListState>
    implements _$$_TransactionListStateCopyWith<$Res> {
  __$$_TransactionListStateCopyWithImpl(_$_TransactionListState _value,
      $Res Function(_$_TransactionListState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? transactionRepository = null,
  }) {
    return _then(_$_TransactionListState(
      transactionRepository: null == transactionRepository
          ? _value.transactionRepository
          : transactionRepository // ignore: cast_nullable_to_non_nullable
              as ITransactionRepository,
    ));
  }
}

/// @nodoc

class _$_TransactionListState
    with DiagnosticableTreeMixin
    implements _TransactionListState {
  _$_TransactionListState({required this.transactionRepository});

  @override
  final ITransactionRepository transactionRepository;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'TransactionListState(transactionRepository: $transactionRepository)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'TransactionListState'))
      ..add(
          DiagnosticsProperty('transactionRepository', transactionRepository));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TransactionListState &&
            (identical(other.transactionRepository, transactionRepository) ||
                other.transactionRepository == transactionRepository));
  }

  @override
  int get hashCode => Object.hash(runtimeType, transactionRepository);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TransactionListStateCopyWith<_$_TransactionListState> get copyWith =>
      __$$_TransactionListStateCopyWithImpl<_$_TransactionListState>(
          this, _$identity);
}

abstract class _TransactionListState implements TransactionListState {
  factory _TransactionListState(
          {required final ITransactionRepository transactionRepository}) =
      _$_TransactionListState;

  @override
  ITransactionRepository get transactionRepository;
  @override
  @JsonKey(ignore: true)
  _$$_TransactionListStateCopyWith<_$_TransactionListState> get copyWith =>
      throw _privateConstructorUsedError;
}
