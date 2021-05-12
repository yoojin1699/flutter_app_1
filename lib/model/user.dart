import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String username;
  String email;
  String imagePath;
  // String photoUrl;
  // String country;
  // String bio;
  // String id;
  // Timestamp signedUpAt;
  // Timestamp lastSeen;
  // bool isOnline;

  UserModel({this.username, this.email, this.imagePath
      // this.id,
      // this.photoUrl,
      // this.signedUpAt,
      // this.isOnline,
      // this.lastSeen,
      // this.bio,
      // this.country
      });

  UserModel.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    email = json['email'];
    imagePath = json['imagePath'];
    // country = json['country'];
    // photoUrl = json['photoUrl'];
    // signedUpAt = json['signedUpAt'];
    // isOnline = json['isOnline'];
    // lastSeen = json['lastSeen'];
    // bio = json['bio'];
    // id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['username'] = this.username;
    data['email'] = this.email;
    data['imagePath'] = this.imagePath;
    // data['country'] = this.country;
    // data['photoUrl'] = this.photoUrl;
    // data['bio'] = this.bio;
    // data['signedUpAt'] = this.signedUpAt;
    // data['isOnline'] = this.isOnline;
    // data['lastSeen'] = this.lastSeen;
    // data['id'] = this.id;

    return data;
  }
}
