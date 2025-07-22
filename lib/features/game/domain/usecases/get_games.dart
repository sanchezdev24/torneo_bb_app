import '../entities/game.dart';
import '../repositories/game_repository.dart';

class GetGames {
  final GameRepository repository;

  GetGames(this.repository);

  Future<List<Game>> call() async {
    return await repository.getGames();
  }
}