import 'package:equatable/equatable.dart';

enum EventType {
  point1,
  point2,
  point3,
  freeThrow,
  assist,
  rebound,
  steal,
  block,
  turnover,
  substitution,
}

class GameEvent extends Equatable {
  final String id;
  final String gameId;
  final String? playerId;
  final String team; // 'A' or 'B'
  final int quarter;
  final EventType eventType;
  final int points;
  final String? timeRemaining;
  final String? description;
  final DateTime createdAt;

  const GameEvent({
    required this.id,
    required this.gameId,
    this.playerId,
    required this.team,
    required this.quarter,
    required this.eventType,
    this.points = 0,
    this.timeRemaining,
    this.description,
    required this.createdAt,
  });

  GameEvent copyWith({
    String? id,
    String? gameId,
    String? playerId,
    String? team,
    int? quarter,
    EventType? eventType,
    int? points,
    String? timeRemaining,
    String? description,
    DateTime? createdAt,
  }) {
    return GameEvent(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      playerId: playerId ?? this.playerId,
      team: team ?? this.team,
      quarter: quarter ?? this.quarter,
      eventType: eventType ?? this.eventType,
      points: points ?? this.points,
      timeRemaining: timeRemaining ?? this.timeRemaining,
      description: description ?? this.description,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        gameId,
        playerId,
        team,
        quarter,
        eventType,
        points,
        timeRemaining,
        description,
        createdAt,
      ];
}