import 'package:equatable/equatable.dart';

class Timeout extends Equatable {
  final String id;
  final String gameId;
  final String team; // 'A' or 'B'
  final int quarter;
  final String? timeRemaining;
  final DateTime createdAt;

  const Timeout({
    required this.id,
    required this.gameId,
    required this.team,
    required this.quarter,
    this.timeRemaining,
    required this.createdAt,
  });

  Timeout copyWith({
    String? id,
    String? gameId,
    String? team,
    int? quarter,
    String? timeRemaining,
    DateTime? createdAt,
  }) {
    return Timeout(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      team: team ?? this.team,
      quarter: quarter ?? this.quarter,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        gameId,
        team,
        quarter,
        timeRemaining,
        createdAt,
      ];
}