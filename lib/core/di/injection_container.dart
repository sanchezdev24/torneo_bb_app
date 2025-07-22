import 'package:get_it/get_it.dart';
import '../database/database_helper.dart';
import '../../features/game/data/datasources/game_local_data_source.dart';
import '../../features/game/data/repositories/game_repository_impl.dart';
import '../../features/game/domain/repositories/game_repository.dart';
import '../../features/game/domain/usecases/create_game.dart';
import '../../features/game/domain/usecases/get_game.dart';
import '../../features/game/domain/usecases/get_games.dart';
import '../../features/game/domain/usecases/update_game.dart';
import '../../features/game/domain/usecases/delete_game.dart';
import '../../features/game/presentation/controllers/game_controller.dart';

final sl = GetIt.instance;

Future<void> initializeDependencies() async {
  // Database
  sl.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // Data sources
  sl.registerLazySingleton<GameLocalDataSource>(
    () => GameLocalDataSourceImpl(sl()),
  );

  // Repositories
  sl.registerLazySingleton<GameRepository>(
    () => GameRepositoryImpl(sl()),
  );

  // Use cases
  sl.registerLazySingleton(() => CreateGame(sl()));
  sl.registerLazySingleton(() => GetGame(sl()));
  sl.registerLazySingleton(() => GetGames(sl()));
  sl.registerLazySingleton(() => UpdateGame(sl()));
  sl.registerLazySingleton(() => DeleteGame(sl()));

  // Controllers
  sl.registerFactory(() => GameController(
    createGame: sl(),
    getGame: sl(),
    getGames: sl(),
    updateGame: sl(),
    deleteGame: sl(),
  ));

  // Initialize database
  await sl<DatabaseHelper>().database;
}