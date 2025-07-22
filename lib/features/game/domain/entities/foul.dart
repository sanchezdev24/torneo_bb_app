import 'package:equatable/equatable.dart';

enum FoulType {
  personal,
  technical,
  unsportsmanlike,
  disqualifying,
  offensive,
  defensive,
}

class Foul extends Equatable {
  final String id;
  final String gameId;
  final String? playerId;
  final String team; // 'A' or 'B'
  final int quarter;
  final FoulType foulType;
  final bool isTechnical;
  final bool isUnsportsmanlike;
  final bool isDisqualifying;
  final DateTime createdAt;

  const Foul({
    required this.id,
    required this.gameId,
    this.playerId,
    required this.team,
    required this.quarter,
    required this.foulType,
    this.isTechnical = false,
    this.isUnsportsmanlike = false,
    this.isDisqualifying = false,
    required this.createdAt,
  });

  Foul copyWith({
    String? id,
    String? gameId,
    String? playerId,
    String? team,
    int? quarter,
    FoulType? foulType,
    bool? isTechnical,
    bool? isUnsportsmanlike,
    bool? isDisqualifying,
    DateTime? createdAt,
  }) {
    return Foul(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      playerId: playerId ?? this.playerId,
      team: team ?? this.team,
      quarter: quarter ?? this.quarter,
      foulType: foulType ?? this.foulType,
      isTechnical: isTechnical ?? this.isTechnical,
      isUnsportsmanlike: isUnsportsmanlike ?? this.isUnsportsmanlike,
      isDisqualifying: isDisqualifying ?? this.isDisqualifying,
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
        foulType,
        isTechnical,
        isUnsportsmanlike,
        isDisqualifying,
        createdAt,
      ];
}