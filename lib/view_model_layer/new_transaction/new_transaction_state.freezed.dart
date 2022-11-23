// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'new_transaction_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$NewTransactionState {
  DateTime get selectedDate => throw _privateConstructorUsedError;
  TextEditingController get titleController =>
      throw _privateConstructorUsedError;
  TextEditingController get amountController =>
      throw _privateConstructorUsedError;
  FocusNode get nodeTitle => throw _privateConstructorUsedError;
  FocusNode get nodeAmount => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $NewTransactionStateCopyWith<NewTransactionState> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewTransactionStateCopyWith<$Res> {
  factory $NewTransactionStateCopyWith(
          NewTransactionState value, $Res Function(NewTransactionState) then) =
      _$NewTransactionStateCopyWithImpl<$Res, NewTransactionState>;
  @useResult
  $Res call(
      {DateTime selectedDate,
      TextEditingController titleController,
      TextEditingController amountController,
      FocusNode nodeTitle,
      FocusNode nodeAmount});
}

/// @nodoc
class _$NewTransactionStateCopyWithImpl<$Res, $Val extends NewTransactionState>
    implements $NewTransactionStateCopyWith<$Res> {
  _$NewTransactionStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? titleController = null,
    Object? amountController = null,
    Object? nodeTitle = null,
    Object? nodeAmount = null,
  }) {
    return _then(_value.copyWith(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      titleController: null == titleController
          ? _value.titleController
          : titleController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      amountController: null == amountController
          ? _value.amountController
          : amountController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      nodeTitle: null == nodeTitle
          ? _value.nodeTitle
          : nodeTitle // ignore: cast_nullable_to_non_nullable
              as FocusNode,
      nodeAmount: null == nodeAmount
          ? _value.nodeAmount
          : nodeAmount // ignore: cast_nullable_to_non_nullable
              as FocusNode,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NewTransactionStateCopyWith<$Res>
    implements $NewTransactionStateCopyWith<$Res> {
  factory _$$_NewTransactionStateCopyWith(_$_NewTransactionState value,
          $Res Function(_$_NewTransactionState) then) =
      __$$_NewTransactionStateCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {DateTime selectedDate,
      TextEditingController titleController,
      TextEditingController amountController,
      FocusNode nodeTitle,
      FocusNode nodeAmount});
}

/// @nodoc
class __$$_NewTransactionStateCopyWithImpl<$Res>
    extends _$NewTransactionStateCopyWithImpl<$Res, _$_NewTransactionState>
    implements _$$_NewTransactionStateCopyWith<$Res> {
  __$$_NewTransactionStateCopyWithImpl(_$_NewTransactionState _value,
      $Res Function(_$_NewTransactionState) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? selectedDate = null,
    Object? titleController = null,
    Object? amountController = null,
    Object? nodeTitle = null,
    Object? nodeAmount = null,
  }) {
    return _then(_$_NewTransactionState(
      selectedDate: null == selectedDate
          ? _value.selectedDate
          : selectedDate // ignore: cast_nullable_to_non_nullable
              as DateTime,
      titleController: null == titleController
          ? _value.titleController
          : titleController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      amountController: null == amountController
          ? _value.amountController
          : amountController // ignore: cast_nullable_to_non_nullable
              as TextEditingController,
      nodeTitle: null == nodeTitle
          ? _value.nodeTitle
          : nodeTitle // ignore: cast_nullable_to_non_nullable
              as FocusNode,
      nodeAmount: null == nodeAmount
          ? _value.nodeAmount
          : nodeAmount // ignore: cast_nullable_to_non_nullable
              as FocusNode,
    ));
  }
}

/// @nodoc

class _$_NewTransactionState
    with DiagnosticableTreeMixin
    implements _NewTransactionState {
  const _$_NewTransactionState(
      {required this.selectedDate,
      required this.titleController,
      required this.amountController,
      required this.nodeTitle,
      required this.nodeAmount});

  @override
  final DateTime selectedDate;
  @override
  final TextEditingController titleController;
  @override
  final TextEditingController amountController;
  @override
  final FocusNode nodeTitle;
  @override
  final FocusNode nodeAmount;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'NewTransactionState(selectedDate: $selectedDate, titleController: $titleController, amountController: $amountController, nodeTitle: $nodeTitle, nodeAmount: $nodeAmount)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'NewTransactionState'))
      ..add(DiagnosticsProperty('selectedDate', selectedDate))
      ..add(DiagnosticsProperty('titleController', titleController))
      ..add(DiagnosticsProperty('amountController', amountController))
      ..add(DiagnosticsProperty('nodeTitle', nodeTitle))
      ..add(DiagnosticsProperty('nodeAmount', nodeAmount));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_NewTransactionState &&
            (identical(other.selectedDate, selectedDate) ||
                other.selectedDate == selectedDate) &&
            (identical(other.titleController, titleController) ||
                other.titleController == titleController) &&
            (identical(other.amountController, amountController) ||
                other.amountController == amountController) &&
            (identical(other.nodeTitle, nodeTitle) ||
                other.nodeTitle == nodeTitle) &&
            (identical(other.nodeAmount, nodeAmount) ||
                other.nodeAmount == nodeAmount));
  }

  @override
  int get hashCode => Object.hash(runtimeType, selectedDate, titleController,
      amountController, nodeTitle, nodeAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NewTransactionStateCopyWith<_$_NewTransactionState> get copyWith =>
      __$$_NewTransactionStateCopyWithImpl<_$_NewTransactionState>(
          this, _$identity);
}

abstract class _NewTransactionState implements NewTransactionState {
  const factory _NewTransactionState(
      {required final DateTime selectedDate,
      required final TextEditingController titleController,
      required final TextEditingController amountController,
      required final FocusNode nodeTitle,
      required final FocusNode nodeAmount}) = _$_NewTransactionState;

  @override
  DateTime get selectedDate;
  @override
  TextEditingController get titleController;
  @override
  TextEditingController get amountController;
  @override
  FocusNode get nodeTitle;
  @override
  FocusNode get nodeAmount;
  @override
  @JsonKey(ignore: true)
  _$$_NewTransactionStateCopyWith<_$_NewTransactionState> get copyWith =>
      throw _privateConstructorUsedError;
}
