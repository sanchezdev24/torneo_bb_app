import '../entities/game.dart';
import '../repositories/game_repository.dart';

class UpdateGame {
  final GameRepository repository;

  UpdateGame(this.repository);

  Future<Game> call(Game game) async {
    return await repository.updateGame(game);
  }
}