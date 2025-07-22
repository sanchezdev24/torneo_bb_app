import 'package:get/get.dart';
import '../../features/game/presentation/pages/create_game_page.dart';
import '../../features/game/presentation/pages/game_detail_page.dart';
import '../../features/game/presentation/pages/games_list_page.dart';
import '../../features/game/presentation/pages/scorecard_page.dart';

class AppRoutes {
  static const String HOME = '/';
  static const String CREATE_GAME = '/create-game';
  static const String GAME_DETAIL = '/game-detail';
  static const String SCORECARD = '/scorecard';

  static List<GetPage> routes = [
    GetPage(
      name: HOME,
      page: () => const GamesListPage(),
    ),
    GetPage(
      name: CREATE_GAME,
      page: () => const CreateGamePage(),
    ),
    GetPage(
      name: GAME_DETAIL,
      page: () => const GameDetailPage(),
    ),
    GetPage(
      name: SCORECARD,
      page: () => const ScorecardPage(),
    ),
  ];
}