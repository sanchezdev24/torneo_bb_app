import '../../domain/entities/game.dart';
import '../../domain/repositories/game_repository.dart';
import '../datasources/game_local_data_source.dart';
import '../models/game_model.dart';

class GameRepositoryImpl implements GameRepository {
  final GameLocalDataSource localDataSource;

  GameRepositoryImpl(this.localDataSource);

  @override
  Future<Game> createGame(Game game) async {
    final gameModel = GameModel.fromEntity(game);
    return await localDataSource.createGame(gameModel);
  }

  @override
  Future<Game?> getGame(String id) async {
    return await localDataSource.getGame(id);
  }

  @override
  Future<List<Game>> getGames() async {
    return await localDataSource.getGames();
  }

  @override
  Future<Game> updateGame(Game game) async {
    final gameModel = GameModel.fromEntity(game);
    return await localDataSource.updateGame(gameModel);
  }

  @override
  Future<void> deleteGame(String id) async {
    return await localDataSource.deleteGame(id);
  }
}