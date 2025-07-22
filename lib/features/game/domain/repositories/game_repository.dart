import '../entities/game.dart';

abstract class GameRepository {
  Future<Game> createGame(Game game);
  Future<Game?> getGame(String id);
  Future<List<Game>> getGames();
  Future<Game> updateGame(Game game);
  Future<void> deleteGame(String id);
}