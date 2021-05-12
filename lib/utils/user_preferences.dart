import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_application_1/utils/firebase.dart';

import '../model/user.dart';

class UserPreferences {
  static var myUser = UserModel(
    imagePath:
        'https://image-notepet.akamaized.net/resize/620x-/seimage/20200320%2Fc69c31e9dde661c286a3c17201c79d35.jpg',
    username: 'CapstoneDesign',
    email: firebaseAuth.currentUser.email,
  );
}
