import 'package:equatable/equatable.dart';

sealed class StatsEvent extends Equatable {
  const StatsEvent();

  @override
  List<Object?> get props => [];
}

class StatsLoadEvent extends StatsEvent {
  final DateTime? date;

  const StatsLoadEvent({this.date});
}

class StatsDateChangedEvent extends StatsEvent {
  final DateTime? date;

  const StatsDateChangedEvent({this.date});
}

class StatsDeleteTransactionEvent extends StatsEvent {
  final int transactionId;

  const StatsDeleteTransactionEvent(this.transactionId);
}
