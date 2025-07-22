import '../entities/game.dart';
import '../repositories/game_repository.dart';

class CreateGame {
  final GameRepository repository;

  CreateGame(this.repository);

  Future<Game> call(Game game) async {
    return await repository.createGame(game);
  }
}