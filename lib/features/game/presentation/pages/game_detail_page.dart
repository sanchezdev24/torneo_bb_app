import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../core/routes/app_routes.dart';
import '../controllers/game_controller.dart';

class GameDetailPage extends StatelessWidget {
  const GameDetailPage({super.key});

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
        title: const Text('Detalles del Juego'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          Obx(() {
            final game = controller.currentGame.value;
            if (game != null && !game.isFinished) {
              return IconButton(
                icon: const Icon(Icons.sports_basketball),
                onPressed: () {
                  Get.toNamed(
                    AppRoutes.SCORECARD,
                    arguments: {'gameId': gameId},
                  );
                },
                tooltip: 'Abrir Planilla',
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

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Game Status Card
              Card(
                color: game.isFinished 
                    ? Theme.of(context).colorScheme.primaryContainer
                    : Theme.of(context).colorScheme.secondaryContainer,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      if (game.isFinished)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'FINALIZADO',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      else
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.secondary,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Text(
                            'EN CURSO - CUARTO ${game.quarter}',
                            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                              color: Theme.of(context).colorScheme.onSecondary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  game.teamAName,
                                  style: Theme.of(context).textTheme.titleMedium,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '(Local)',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${game.teamAScore}',
                                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: game.winnerTeam == 'A' 
                                        ? Theme.of(context).colorScheme.primary
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Text(
                              'VS',
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Column(
                              children: [
                                Text(
                                  game.teamBName,
                                  style: Theme.of(context).textTheme.titleMedium,
                                  textAlign: TextAlign.center,
                                ),
                                Text(
                                  '(Visitante)',
                                  style: Theme.of(context).textTheme.bodySmall,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  '${game.teamBScore}',
                                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: game.winnerTeam == 'B' 
                                        ? Theme.of(context).colorScheme.primary
                                        : null,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      if (game.winnerTeam != null) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Theme.of(context).colorScheme.primary,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'GANADOR: ${game.winnerTeam == 'A' ? game.teamAName : game.teamBName}',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.onPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Game Information
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Información del Partido',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      _buildInfoRow('Categoría:', game.category),
                      _buildInfoRow('Fase:', game.phase),
                      _buildInfoRow('Jornada:', game.journey),
                      _buildInfoRow('Lugar:', game.location),
                      _buildInfoRow('Fecha:', '${game.date.day}/${game.date.month}/${game.date.year}'),
                      _buildInfoRow('Hora:', game.time),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Officials Information
              if (game.firstJudge != null || 
                  game.secondJudge != null || 
                  game.scorer != null || 
                  game.timekeeper != null || 
                  game.operator24 != null)
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Oficiales del Partido',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 16),
                        if (game.firstJudge != null)
                          _buildInfoRow('1er Juez:', game.firstJudge!),
                        if (game.secondJudge != null)
                          _buildInfoRow('2do Juez:', game.secondJudge!),
                        if (game.scorer != null)
                          _buildInfoRow('Apuntador:', game.scorer!),
                        if (game.timekeeper != null)
                          _buildInfoRow('Cronometrista:', game.timekeeper!),
                        if (game.operator24 != null)
                          _buildInfoRow('Operador de 24":', game.operator24!),
                      ],
                    ),
                  ),
                ),
              const SizedBox(height: 24),

              // Action Button
              if (!game.isFinished)
                ElevatedButton.icon(
                  onPressed: () {
                    Get.toNamed(
                      AppRoutes.SCORECARD,
                      arguments: {'gameId': gameId},
                    );
                  },
                  icon: const Icon(Icons.sports_basketball),
                  label: const Text('Abrir Planilla de Juego'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}