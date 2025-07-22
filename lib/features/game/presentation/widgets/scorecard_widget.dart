import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../domain/entities/game.dart';
import '../controllers/game_controller.dart';

class ScorecardWidget extends StatefulWidget {
  final Game game;

  const ScorecardWidget({super.key, required this.game});

  @override
  State<ScorecardWidget> createState() => _ScorecardWidgetState();
}

class _ScorecardWidgetState extends State<ScorecardWidget> {
  final controller = Get.find<GameController>();
  late int teamAScore;
  late int teamBScore;
  int currentQuarter = 1;

  // Score tracking for each quarter
  final Map<int, Map<String, List<int>>> quarterScores = {
    1: {'A': [], 'B': []},
    2: {'A': [], 'B': []},
    3: {'A': [], 'B': []},
    4: {'A': [], 'B': []},
  };

  @override
  void initState() {
    super.initState();
    teamAScore = widget.game.teamAScore;
    teamBScore = widget.game.teamBScore;
    currentQuarter = widget.game.quarter;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Header with tournament info
          Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.primaryContainer,
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Text(
                  'TORNEO FEDERAL DE BÁSQUETBOL',
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  'PLANILLA OFICIAL DE JUEGO',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimaryContainer,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Game info section
                _buildGameInfoSection(),
                const SizedBox(height: 16),
                
                // Score section
                _buildScoreSection(),
                const SizedBox(height: 16),
                
                // Progressive score table
                _buildProgressiveScoreTable(),
                const SizedBox(height: 16),
                
                // Quarter controls
                if (!widget.game.isFinished) _buildQuarterControls(),
                const SizedBox(height: 16),
                
                // Officials section
                _buildOfficialsSection(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGameInfoSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: _buildInfoField('Categoría:', widget.game.category),
                ),
                Expanded(
                  child: _buildInfoField('Lugar:', widget.game.location),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildInfoField('Fase:', widget.game.phase),
                ),
                Expanded(
                  child: _buildInfoField('Fecha:', '${widget.game.date.day}/${widget.game.date.month}/${widget.game.date.year}'),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: _buildInfoField('Jornada:', widget.game.journey),
                ),
                Expanded(
                  child: _buildInfoField('Hora:', widget.game.time),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }

  Widget _buildScoreSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'MARCADOR',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        widget.game.teamAName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '(Local "A")',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.primaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$teamAScore',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (!widget.game.isFinished) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () => _addPoints('A', 1),
                              child: const Text('+1'),
                            ),
                            ElevatedButton(
                              onPressed: () => _addPoints('A', 2),
                              child: const Text('+2'),
                            ),
                            ElevatedButton(
                              onPressed: () => _addPoints('A', 3),
                              child: const Text('+3'),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'VS',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        widget.game.teamBName,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        '(Visitante "B")',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondaryContainer,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          '$teamBScore',
                          style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      if (!widget.game.isFinished) ...[
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ElevatedButton(
                              onPressed: () => _addPoints('B', 1),
                              child: const Text('+1'),
                            ),
                            ElevatedButton(
                              onPressed: () => _addPoints('B', 2),
                              child: const Text('+2'),
                            ),
                            ElevatedButton(
                              onPressed: () => _addPoints('B', 3),
                              child: const Text('+3'),
                            ),
                          ],
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressiveScoreTable() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'PUNTAJE PROGRESIVO',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                border: TableBorder.all(color: Theme.of(context).dividerColor),
                columnWidths: const {
                  0: FixedColumnWidth(30),
                  1: FixedColumnWidth(30),
                  2: FixedColumnWidth(30),
                  3: FixedColumnWidth(30),
                  4: FixedColumnWidth(30),
                  5: FixedColumnWidth(30),
                  6: FixedColumnWidth(30),
                  7: FixedColumnWidth(30),
                  8: FixedColumnWidth(30),
                  9: FixedColumnWidth(30),
                },
                children: [
                  // Header row
                  TableRow(
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.surfaceVariant,
                    ),
                    children: [
                      _buildTableCell('A', isHeader: true),
                      _buildTableCell('J', isHeader: true),
                      _buildTableCell('B', isHeader: true),
                      _buildTableCell('J', isHeader: true),
                      _buildTableCell('A', isHeader: true),
                      _buildTableCell('J', isHeader: true),
                      _buildTableCell('B', isHeader: true),
                      _buildTableCell('J', isHeader: true),
                      _buildTableCell('A', isHeader: true),
                      _buildTableCell('J', isHeader: true),
                    ],
                  ),
                  // Score rows (simplified for demo)
                  for (int i = 1; i <= 20; i++)
                    TableRow(
                      children: [
                        _buildTableCell('${i}'),
                        _buildTableCell('${i}'),
                        _buildTableCell('${i + 40}'),
                        _buildTableCell('${i + 40}'),
                        _buildTableCell('${i + 80}'),
                        _buildTableCell('${i + 80}'),
                        _buildTableCell('${i + 120}'),
                        _buildTableCell('${i + 120}'),
                        _buildTableCell('${i + 160}'),
                        _buildTableCell('${i + 160}'),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableCell(String text, {bool isHeader = false}) {
    return Container(
      height: 30,
      alignment: Alignment.center,
      child: Text(
        text,
        style: TextStyle(
          fontSize: 12,
          fontWeight: isHeader ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }

  Widget _buildQuarterControls() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              'CUARTO ACTUAL: $currentQuarter',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: currentQuarter > 1 
                      ? () => setState(() => currentQuarter--) 
                      : null,
                  child: const Text('Cuarto Anterior'),
                ),
                ElevatedButton(
                  onPressed: currentQuarter < 4 
                      ? () => setState(() => currentQuarter++) 
                      : null,
                  child: const Text('Siguiente Cuarto'),
                ),
              ],
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () => _updateScore(),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
              ),
              child: const Text('Actualizar Marcador'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOfficialsSection() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'OFICIALES DEL PARTIDO',
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            _buildOfficialField('1er Juez:', widget.game.firstJudge ?? ''),
            _buildOfficialField('2do Juez:', widget.game.secondJudge ?? ''),
            _buildOfficialField('Apuntador:', widget.game.scorer ?? ''),
            _buildOfficialField('Cronometrista:', widget.game.timekeeper ?? ''),
            _buildOfficialField('Operador de 24":', widget.game.operator24 ?? ''),
          ],
        ),
      ),
    );
  }

  Widget _buildOfficialField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 120,
            child: Text(
              label,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                border: Border.all(color: Theme.of(context).dividerColor),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(value.isEmpty ? '___________________' : value),
            ),
          ),
        ],
      ),
    );
  }

  void _addPoints(String team, int points) {
    setState(() {
      if (team == 'A') {
        teamAScore += points;
        quarterScores[currentQuarter]!['A']!.add(points);
      } else {
        teamBScore += points;
        quarterScores[currentQuarter]!['B']!.add(points);
      }
    });
  }

  void _updateScore() {
    controller.updateGameScore(widget.game.id, teamAScore, teamBScore);
    Get.snackbar(
      'Marcador Actualizado',
      'Equipo A: $teamAScore - Equipo B: $teamBScore',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}