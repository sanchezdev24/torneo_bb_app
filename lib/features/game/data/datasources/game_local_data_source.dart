import '../../../../core/database/database_helper.dart';
import '../models/game_model.dart';

abstract class GameLocalDataSource {
  Future<GameModel> createGame(GameModel game);
  Future<GameModel?> getGame(String id);
  Future<List<GameModel>> getGames();
  Future<GameModel> updateGame(GameModel game);
  Future<void> deleteGame(String id);
}

class GameLocalDataSourceImpl implements GameLocalDataSource {
  final DatabaseHelper databaseHelper;

  GameLocalDataSourceImpl(this.databaseHelper);

  @override
  Future<GameModel> createGame(GameModel game) async {
    final db = await databaseHelper.database;
    await db.insert('games', game.toMap());
    return game;
  }

  @override
  Future<GameModel?> getGame(String id) async {
    final db = await databaseHelper.database;
    final maps = await db.query(
      'games',
      where: 'id = ?',
      whereArgs: [id],
    );

    if (maps.isNotEmpty) {
      return GameModel.fromMap(maps.first);
    }
    return null;
  }

  @override
  Future<List<GameModel>> getGames() async {
    final db = await databaseHelper.database;
    final maps = await db.query(
      'games',
      orderBy: 'created_at DESC',
    );

    return List.generate(maps.length, (i) {
      return GameModel.fromMap(maps[i]);
    });
  }

  @override
  Future<GameModel> updateGame(GameModel game) async {
    final db = await databaseHelper.database;
    await db.update(
      'games',
      game.toMap(),
      where: 'id = ?',
      whereArgs: [game.id],
    );
    return game;
  }

  @override
  Future<void> deleteGame(String id) async {
    final db = await databaseHelper.database;
    await db.delete(
      'games',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}