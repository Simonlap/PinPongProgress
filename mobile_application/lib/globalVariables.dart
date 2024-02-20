import 'package:mobile_application/entities/group.dart';
import 'package:mobile_application/entities/player.dart';
import 'package:mobile_application/entities/uniqueGame.dart';

String? username = null;
String? useremail = null;
int? userid = null;
List<dynamic>? userroles = null;
String? jwtToken = null;

List<Player> player = [];
List<Group> groups = [];

UniqueGame? currentUniqueGame = null;

String apiUrl = 'http://10.0.2.2:8080';