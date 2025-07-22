import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';
import '../widgets/scorecard_widget.dart';

class ScorecardPage extends StatelessWidget {
  const ScorecardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<GameController>();
    final gameId = Get.arguments['gameId'] as String;

    // Load the game when the page is opened
    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.loadGame(gameId);
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Planilla Oficial de Juego'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Obx(() {
            final game = controller.currentGame.value;
            if (game != null && !game.isFinished) {
              return PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'finish_game') {
                    _showFinishGameDialog(context, controller, gameId);
                  }
                },
                itemBuilder: (BuildContext context) => [
                  const PopupMenuItem<String>(
                    value: 'finish_game',
                    child: Row(
                      children: [
                        Icon(Icons.flag),
                        SizedBox(width: 8),
                        Text('Finalizar Juego'),
                      ],
                    ),
                  ),
                ],
              );
            }
            return const SizedBox.shrink();
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final game = controller.currentGame.value;
        if (game == null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Theme.of(context).colorScheme.error,
                ),
                const SizedBox(height: 16),
                const Text('No se pudo cargar el juego'),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => controller.loadGame(gameId),
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }

        return ScorecardWidget(game: game);
      }),
    );
  }

  void _showFinishGameDialog(BuildContext context, GameController controller, String gameId) {
    final game = controller.currentGame.value;
    if (game == null) return;

    String winnerTeam = '';
    if (game.teamAScore > game.teamBScore) {
      winnerTeam = 'A';
    } else if (game.teamBScore > game.teamAScore) {
      winnerTeam = 'B';
    }

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Finalizar Juego'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Marcador Final:'),
              const SizedBox(height: 8),
              Text('${game.teamAName}: ${game.teamAScore}'),
              Text('${game.teamBName}: ${game.teamBScore}'),
              const SizedBox(height: 16),
              if (winnerTeam.isNotEmpty)
                Text(
                  'Ganador: ${winnerTeam == 'A' ? game.teamAName : game.teamBName}',
                  style: const TextStyle(fontWeight: FontWeight.bold),
                )
              else
                const Text(
                  'El juego está empatado. ¿Desea finalizar de todas formas?',
                  style: TextStyle(color: Colors.orange),
                ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.finishGame(gameId, winnerTeam);
                Get.back(); // Return to game detail
              },
              child: const Text('Finalizar'),
            ),
          ],
        );
      },
    );
  }
}