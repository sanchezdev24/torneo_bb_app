import 'package:get/get.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/game.dart';
import '../../domain/usecases/create_game.dart';
import '../../domain/usecases/get_game.dart';
import '../../domain/usecases/get_games.dart';
import '../../domain/usecases/update_game.dart';
import '../../domain/usecases/delete_game.dart';

class GameController extends GetxController {
  final CreateGame createGame;
  final GetGame getGame;
  final GetGames getGames;
  final UpdateGame updateGame;
  final DeleteGame deleteGame;

  GameController({
    required this.createGame,
    required this.getGame,
    required this.getGames,
    required this.updateGame,
    required this.deleteGame,
  });

  // Observable variables
  final RxList<Game> games = <Game>[].obs;
  final Rxn<Game> currentGame = Rxn<Game>();
  final RxBool isLoading = false.obs;
  final RxString error = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadGames();
  }

  Future<void> loadGames() async {
    try {
      isLoading.value = true;
      error.value = '';
      final gamesList = await getGames();
      games.value = gamesList;
    } catch (e) {
      error.value = 'Error al cargar los juegos: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadGame(String id) async {
    try {
      isLoading.value = true;
      error.value = '';
      final game = await getGame(id);
      currentGame.value = game;
    } catch (e) {
      error.value = 'Error al cargar el juego: $e';
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> createNewGame({
    required String category,
    required String phase,
    required String journey,
    required String location,
    required DateTime date,
    required String time,
    required String teamAName,
    required String teamBName,
    String? firstJudge,
    String? secondJudge,
    String? scorer,
    String? timekeeper,
    String? operator24,
  }) async {
    try {
      isLoading.value = true;
      error.value = '';
      
      final now = DateTime.now();
      final game = Game(
        id: const Uuid().v4(),
        category: category,
        phase: phase,
        journey: journey,
        location: location,
        date: date,
        time: time,
        teamAName: teamAName,
        teamBName: teamBName,
        firstJudge: firstJudge,
        secondJudge: secondJudge,
        scorer: scorer,
        timekeeper: timekeeper,
        operator24: operator24,
        createdAt: now,
        updatedAt: now,
      );

      final createdGame = await createGame(game);
      games.insert(0, createdGame);
      Get.back();
      Get.snackbar(
        'Éxito',
        'Juego creado correctamente',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      error.value = 'Error al crear el juego: $e';
      Get.snackbar(
        'Error',
        'Error al crear el juego: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> updateGameScore(String gameId, int teamAScore, int teamBScore) async {
    try {
      final game = currentGame.value;
      if (game == null) return;

      final updatedGame = game.copyWith(
        teamAScore: teamAScore,
        teamBScore: teamBScore,
        updatedAt: DateTime.now(),
      );

      await updateGame(updatedGame);
      currentGame.value = updatedGame;
      
      // Update in the list as well
      final index = games.indexWhere((g) => g.id == gameId);
      if (index != -1) {
        games[index] = updatedGame;
      }
    } catch (e) {
      error.value = 'Error al actualizar el marcador: $e';
    }
  }

  Future<void> finishGame(String gameId, String winnerTeam) async {
    try {
      final game = currentGame.value;
      if (game == null) return;

      final updatedGame = game.copyWith(
        isFinished: true,
        winnerTeam: winnerTeam,
        updatedAt: DateTime.now(),
      );

      await updateGame(updatedGame);
      currentGame.value = updatedGame;
      
      // Update in the list as well
      final index = games.indexWhere((g) => g.id == gameId);
      if (index != -1) {
        games[index] = updatedGame;
      }

      Get.snackbar(
        'Juego Finalizado',
        'El equipo $winnerTeam ha ganado',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      error.value = 'Error al finalizar el juego: $e';
    }
  }

  Future<void> removeGame(String id) async {
    try {
      await deleteGame(id);
      games.removeWhere((game) => game.id == id);
      Get.snackbar(
        'Éxito',
        'Juego eliminado correctamente',
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      error.value = 'Error al eliminar el juego: $e';
      Get.snackbar(
        'Error',
        'Error al eliminar el juego: $e',
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  void clearError() {
    error.value = '';
  }
}