import 'package:flutter/material.dart';
import 'package:mobile_application/pages/addPlayer_page.dart';
import 'package:mobile_application/pages/home_page.dart';
import 'package:mobile_application/pages/login_page.dart';
import 'package:mobile_application/pages/managePlayers_page.dart';
import 'package:mobile_application/pages/manage_groups.dart';
import 'package:mobile_application/pages/minispiele_page.dart';
import 'package:mobile_application/pages/navigation_page.dart';
import 'package:mobile_application/pages/statisticsEloGain.dart';
import 'package:mobile_application/pages/statisticsEloRating.dart';
import 'package:mobile_application/pages/playerSelectionGroup_page.dart';
import 'package:mobile_application/pages/profile_page.dart';
import 'package:mobile_application/pages/register_page.dart';
import 'package:mobile_application/pages/runningUniqueGames_page.dart';
import 'package:mobile_application/pages/start_page.dart';
import 'package:mobile_application/pages/statisticsLeaderBoard_page.dart';
import 'package:mobile_application/pages/statisticsOverview_page.dart';
import 'package:mobile_application/pages/tools_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: StartPage(),
      routes: {
        '/startpage' :(context) => StartPage(),
        '/loginpage' :(context) => LoginPage(),
        '/registerpage' :(context) => RegisterPage(),
        '/navigationpage' :(context) => NavigationPage(),
        '/homepage' :(context) => HomePage(),
        '/profilePage' :(context) => ProfilePage(),
        '/minispielepage' :(context) => MinispielePage(),
        '/manageplayerspage' :(context) => ManagePlayersPage(),
        '/addplayerpage' :(context) => AddPlayerPage(),
        '/toolspage' :(context) => ToolsPage(),
        '/managegroupspage' :(context) => ManageGroupsPage(),
        '/playerselectiongrouppage' :(context) => PlayersSelectionGroupPage(),
        '/playerelochartpage' :(context) => StatisticsEloRatingPage(),
        '/statisticsoverviewpage' :(context) => StatisticsOverviewPage(),
        '/statisticselogainpage' :(context) => StatisticsEloGainPage(),
        '/runninguniquegamespage':(context) => RunningUniqueGamesPage(),
        '/statisticsleaderboardpage' :(context) => StatisticsLeaderBoardPage(),
      }
    );
  }
}
