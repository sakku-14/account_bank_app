import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'chart_bar_state.freezed.dart';

@freezed
abstract class ChartBarState with _$ChartBarState {
  const factory ChartBarState() = _ChartBarState;
}
