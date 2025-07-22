import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/game_controller.dart';

class CreateGamePage extends StatefulWidget {
  const CreateGamePage({super.key});

  @override
  State<CreateGamePage> createState() => _CreateGamePageState();
}

class _CreateGamePageState extends State<CreateGamePage> {
  final _formKey = GlobalKey<FormState>();
  final controller = Get.find<GameController>();

  // Form controllers
  final _categoryController = TextEditingController();
  final _phaseController = TextEditingController();
  final _journeyController = TextEditingController();
  final _locationController = TextEditingController();
  final _timeController = TextEditingController();
  final _teamAController = TextEditingController();
  final _teamBController = TextEditingController();
  final _firstJudgeController = TextEditingController();
  final _secondJudgeController = TextEditingController();
  final _scorerController = TextEditingController();
  final _timekeeperController = TextEditingController();
  final _operator24Controller = TextEditingController();

  DateTime _selectedDate = DateTime.now();

  @override
  void dispose() {
    _categoryController.dispose();
    _phaseController.dispose();
    _journeyController.dispose();
    _locationController.dispose();
    _timeController.dispose();
    _teamAController.dispose();
    _teamBController.dispose();
    _firstJudgeController.dispose();
    _secondJudgeController.dispose();
    _scorerController.dispose();
    _timekeeperController.dispose();
    _operator24Controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Crear Nuevo Juego'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Información del Torneo',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _categoryController,
                        decoration: const InputDecoration(
                          labelText: 'Categoría',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'La categoría es obligatoria';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: _phaseController,
                              decoration: const InputDecoration(
                                labelText: 'Fase',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'La fase es obligatoria';
                                }
                                return null;
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _journeyController,
                              decoration: const InputDecoration(
                                labelText: 'Jornada',
                                border: OutlineInputBorder(),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'La jornada es obligatoria';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Detalles del Partido',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _locationController,
                        decoration: const InputDecoration(
                          labelText: 'Lugar',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El lugar es obligatorio';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: InkWell(
                              onTap: () => _selectDate(context),
                              child: InputDecorator(
                                decoration: const InputDecoration(
                                  labelText: 'Fecha',
                                  border: OutlineInputBorder(),
                                ),
                                child: Text(
                                  '${_selectedDate.day}/${_selectedDate.month}/${_selectedDate.year}',
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: TextFormField(
                              controller: _timeController,
                              decoration: const InputDecoration(
                                labelText: 'Hora',
                                border: OutlineInputBorder(),
                                hintText: 'ej: 15:30',
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'La hora es obligatoria';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Equipos',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _teamAController,
                        decoration: const InputDecoration(
                          labelText: 'Equipo Local (A)',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El equipo local es obligatorio';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _teamBController,
                        decoration: const InputDecoration(
                          labelText: 'Equipo Visitante (B)',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'El equipo visitante es obligatorio';
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
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
                      TextFormField(
                        controller: _firstJudgeController,
                        decoration: const InputDecoration(
                          labelText: '1er Juez',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _secondJudgeController,
                        decoration: const InputDecoration(
                          labelText: '2do Juez',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _scorerController,
                        decoration: const InputDecoration(
                          labelText: 'Apuntador',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _timekeeperController,
                        decoration: const InputDecoration(
                          labelText: 'Cronometrista',
                          border: OutlineInputBorder(),
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextFormField(
                        controller: _operator24Controller,
                        decoration: const InputDecoration(
                          labelText: 'Operador de 24"',
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),
              Obx(() => ElevatedButton(
                onPressed: controller.isLoading.value ? null : _createGame,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: controller.isLoading.value
                    ? const CircularProgressIndicator()
                    : const Text('Crear Juego'),
              )),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now().subtract(const Duration(days: 365)),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _createGame() {
    if (_formKey.currentState!.validate()) {
      controller.createNewGame(
        category: _categoryController.text,
        phase: _phaseController.text,
        journey: _journeyController.text,
        location: _locationController.text,
        date: _selectedDate,
        time: _timeController.text,
        teamAName: _teamAController.text,
        teamBName: _teamBController.text,
        firstJudge: _firstJudgeController.text.isEmpty ? null : _firstJudgeController.text,
        secondJudge: _secondJudgeController.text.isEmpty ? null : _secondJudgeController.text,
        scorer: _scorerController.text.isEmpty ? null : _scorerController.text,
        timekeeper: _timekeeperController.text.isEmpty ? null : _timekeeperController.text,
        operator24: _operator24Controller.text.isEmpty ? null : _operator24Controller.text,
      );
    }
  } 
}