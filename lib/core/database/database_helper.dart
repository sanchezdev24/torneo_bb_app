import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../config/app_config.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), AppConfig.databaseName);
    return await openDatabase(
      path,
      version: AppConfig.databaseVersion,
      onCreate: _createTables,
    );
  }

  Future<void> _createTables(Database db, int version) async {
    await db.execute('''
      CREATE TABLE games (
        id TEXT PRIMARY KEY,
        category TEXT NOT NULL,
        phase TEXT NOT NULL,
        journey TEXT NOT NULL,
        location TEXT NOT NULL,
        date TEXT NOT NULL,
        time TEXT NOT NULL,
        team_a_name TEXT NOT NULL,
        team_b_name TEXT NOT NULL,
        team_a_score INTEGER DEFAULT 0,
        team_b_score INTEGER DEFAULT 0,
        quarter INTEGER DEFAULT 1,
        is_finished INTEGER DEFAULT 0,
        winner_team TEXT,
        first_judge TEXT,
        second_judge TEXT,
        scorer TEXT,
        timekeeper TEXT,
        operator_24 TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT NOT NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE players (
        id TEXT PRIMARY KEY,
        game_id TEXT NOT NULL,
        team TEXT NOT NULL,
        jersey_number INTEGER NOT NULL,
        name TEXT NOT NULL,
        is_captain INTEGER DEFAULT 0,
        is_technical_director INTEGER DEFAULT 0,
        is_assistant INTEGER DEFAULT 0,
        signature TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (game_id) REFERENCES games (id) ON DELETE CASCADE
      )
    ''');

    await db.execute('''
      CREATE TABLE game_events (
        id TEXT PRIMARY KEY,
        game_id TEXT NOT NULL,
        player_id TEXT,
        team TEXT NOT NULL,
        quarter INTEGER NOT NULL,
        event_type TEXT NOT NULL,
        points INTEGER DEFAULT 0,
        time_remaining TEXT,
        description TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (game_id) REFERENCES games (id) ON DELETE CASCADE,
        FOREIGN KEY (player_id) REFERENCES players (id) ON DELETE SET NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE fouls (
        id TEXT PRIMARY KEY,
        game_id TEXT NOT NULL,
        player_id TEXT,
        team TEXT NOT NULL,
        quarter INTEGER NOT NULL,
        foul_type TEXT NOT NULL,
        is_technical INTEGER DEFAULT 0,
        is_unsportsmanlike INTEGER DEFAULT 0,
        is_disqualifying INTEGER DEFAULT 0,
        created_at TEXT NOT NULL,
        FOREIGN KEY (game_id) REFERENCES games (id) ON DELETE CASCADE,
        FOREIGN KEY (player_id) REFERENCES players (id) ON DELETE SET NULL
      )
    ''');

    await db.execute('''
      CREATE TABLE timeouts (
        id TEXT PRIMARY KEY,
        game_id TEXT NOT NULL,
        team TEXT NOT NULL,
        quarter INTEGER NOT NULL,
        time_remaining TEXT,
        created_at TEXT NOT NULL,
        FOREIGN KEY (game_id) REFERENCES games (id) ON DELETE CASCADE
      )
    ''');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}