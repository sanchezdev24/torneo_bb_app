import 'package:equatable/equatable.dart';
import 'player.dart';
import 'game_event.dart';
import 'foul.dart';
import 'timeout.dart';

class Game extends Equatable {
  final String id;
  final String category;
  final String phase;
  final String journey;
  final String location;
  final DateTime date;
  final String time;
  final String teamAName;
  final String teamBName;
  final int teamAScore;
  final int teamBScore;
  final int quarter;
  final bool isFinished;
  final String? winnerTeam;
  final String? firstJudge;
  final String? secondJudge;
  final String? scorer;
  final String? timekeeper;
  final String? operator24;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Player>? players;
  final List<GameEvent>? events;
  final List<Foul>? fouls;
  final List<Timeout>? timeouts;

  const Game({
    required this.id,
    required this.category,
    required this.phase,
    required this.journey,
    required this.location,
    required this.date,
    required this.time,
    required this.teamAName,
    required this.teamBName,
    this.teamAScore = 0,
    this.teamBScore = 0,
    this.quarter = 1,
    this.isFinished = false,
    this.winnerTeam,
    this.firstJudge,
    this.secondJudge,
    this.scorer,
    this.timekeeper,
    this.operator24,
    required this.createdAt,
    required this.updatedAt,
    this.players,
    this.events,
    this.fouls,
    this.timeouts,
  });

  Game copyWith({
    String? id,
    String? category,
    String? phase,
    String? journey,
    String? location,
    DateTime? date,
    String? time,
    String? teamAName,
    String? teamBName,
    int? teamAScore,
    int? teamBScore,
    int? quarter,
    bool? isFinished,
    String? winnerTeam,
    String? firstJudge,
    String? secondJudge,
    String? scorer,
    String? timekeeper,
    String? operator24,
    DateTime? createdAt,
    DateTime? updatedAt,
    List<Player>? players,
    List<GameEvent>? events,
    List<Foul>? fouls,
    List<Timeout>? timeouts,
  }) {
    return Game(
      id: id ?? this.id,
      category: category ?? this.category,
      phase: phase ?? this.phase,
      journey: journey ?? this.journey,
      location: location ?? this.location,
      date: date ?? this.date,
      time: time ?? this.time,
      teamAName: teamAName ?? this.teamAName,
      teamBName: teamBName ?? this.teamBName,
      teamAScore: teamAScore ?? this.teamAScore,
      teamBScore: teamBScore ?? this.teamBScore,
      quarter: quarter ?? this.quarter,
      isFinished: isFinished ?? this.isFinished,
      winnerTeam: winnerTeam ?? this.winnerTeam,
      firstJudge: firstJudge ?? this.firstJudge,
      secondJudge: secondJudge ?? this.secondJudge,
      scorer: scorer ?? this.scorer,
      timekeeper: timekeeper ?? this.timekeeper,
      operator24: operator24 ?? this.operator24,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      players: players ?? this.players,
      events: events ?? this.events,
      fouls: fouls ?? this.fouls,
      timeouts: timeouts ?? this.timeouts,
    );
  }

  @override
  List<Object?> get props => [
        id,
        category,
        phase,
        journey,
        location,
        date,
        time,
        teamAName,
        teamBName,
        teamAScore,
        teamBScore,
        quarter,
        isFinished,
        winnerTeam,
        firstJudge,
        secondJudge,
        scorer,
        timekeeper,
        operator24,
        createdAt,
        updatedAt,
      ];
}