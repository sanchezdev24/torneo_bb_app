import 'package:equatable/equatable.dart';

class Player extends Equatable {
  final String id;
  final String gameId;
  final String team; // 'A' or 'B'
  final int jerseyNumber;
  final String name;
  final bool isCaptain;
  final bool isTechnicalDirector;
  final bool isAssistant;
  final String? signature;
  final DateTime createdAt;

  const Player({
    required this.id,
    required this.gameId,
    required this.team,
    required this.jerseyNumber,
    required this.name,
    this.isCaptain = false,
    this.isTechnicalDirector = false,
    this.isAssistant = false,
    this.signature,
    required this.createdAt,
  });

  Player copyWith({
    String? id,
    String? gameId,
    String? team,
    int? jerseyNumber,
    String? name,
    bool? isCaptain,
    bool? isTechnicalDirector,
    bool? isAssistant,
    String? signature,
    DateTime? createdAt,
  }) {
    return Player(
      id: id ?? this.id,
      gameId: gameId ?? this.gameId,
      team: team ?? this.team,
      jerseyNumber: jerseyNumber ?? this.jerseyNumber,
      name: name ?? this.name,
      isCaptain: isCaptain ?? this.isCaptain,
      isTechnicalDirector: isTechnicalDirector ?? this.isTechnicalDirector,
      isAssistant: isAssistant ?? this.isAssistant,
      signature: signature ?? this.signature,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [
        id,
        gameId,
        team,
        jerseyNumber,
        name,
        isCaptain,
        isTechnicalDirector,
        isAssistant,
        signature,
        createdAt,
      ];
}