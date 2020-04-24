
import 'dart:math';

import 'package:gesco/models/user.dart';

class UserController{

  static User userOwner = User(id: Random().nextInt(1<<16), login: 'Owner' );

  static User userEngineer1 = User(id: Random().nextInt(1<<16), login: 'Engenheiro' );
  static User userEngineer2 = User(id: Random().nextInt(1<<16), login: 'Engenheiro' );
  static User userEngineer3 = User(id: Random().nextInt(1<<16), login: 'Engenheiro' );

  static User userBuyer1 = User(id: Random().nextInt(1<<16), login: 'Comprador' );
  static User userBuyer2 = User(id: Random().nextInt(1<<16), login: 'Comprador' );
  static User userBuyer3 = User(id: Random().nextInt(1<<16), login: 'Comprador' );

  static List<User> buyers = [userBuyer1, userBuyer2, userBuyer3];
  static List<User> engineers = [userEngineer1, userEngineer2, userEngineer3];

  static User user = userOwner;

}