import '../repositories/game_repository.dart';

class DeleteGame {
  final GameRepository repository;

  DeleteGame(this.repository);

  Future<void> call(String id) async {
    return await repository.deleteGame(id);
  }
}