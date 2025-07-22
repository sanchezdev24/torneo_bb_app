import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/di/injection_container.dart';
import '../../../../core/routes/app_routes.dart';
import '../controllers/game_controller.dart';
import '../widgets/game_card.dart';

class GamesListPage extends StatelessWidget {
  const GamesListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(sl<GameController>());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Planillas de Básquetbol'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (controller.error.value.isNotEmpty) {
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
                Text(
                  controller.error.value,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    controller.clearError();
                    controller.loadGames();
                  },
                  child: const Text('Reintentar'),
                ),
              ],
            ),
          );
        }

        if (controller.games.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.sports_basketball,
                  size: 64,
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
                const SizedBox(height: 16),
                Text(
                  'No hay juegos registrados',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 8),
                Text(
                  'Crea tu primer juego para comenzar',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
              ],
            ),
          );
        }

        return RefreshIndicator(
          onRefresh: () => controller.loadGames(),
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.games.length,
            itemBuilder: (context, index) {
              final game = controller.games[index];
              return GameCard(
                game: game,
                onTap: () {
                  Get.toNamed(
                    AppRoutes.GAME_DETAIL,
                    arguments: {'gameId': game.id},
                  );
                },
                onDelete: () {
                  _showDeleteDialog(context, controller, game.id);
                },
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Get.toNamed(AppRoutes.CREATE_GAME);
        },
        icon: const Icon(Icons.add),
        label: const Text('Nuevo Juego'),
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, GameController controller, String gameId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Eliminar Juego'),
          content: const Text('¿Estás seguro de que quieres eliminar este juego? Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.removeGame(gameId);
              },
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Eliminar'),
            ),
          ],
        );
      },
    );
  }
}