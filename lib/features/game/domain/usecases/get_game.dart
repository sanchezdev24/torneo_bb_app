import '../entities/game.dart';
import '../repositories/game_repository.dart';

class GetGame {
  final GameRepository repository;

  GetGame(this.repository);

  Future<Game?> call(String id) async {
    return await repository.getGame(id);
  }
}