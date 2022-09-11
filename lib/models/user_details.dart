import 'package:cloud_firestore/cloud_firestore.dart';

class UserDetails {
  final String grade;
  final String uid;
  final String userId;
  final String gender;
  final String school;
  final String education;
  final String rollNo;
  final String state;


  const UserDetails(
      {required this.grade,
        required this.uid,
        required this.userId,
        required this.gender,
        required this.school,
        required this.education,
        required this.rollNo,
        required this.state,
        });

  static UserDetails fromSnap(DocumentSnapshot snap) {
    var snapshot = snap.data() as Map<String, dynamic>;

    return UserDetails(
      grade: snapshot["grade"],
      uid: snapshot["uid"],
      userId: snapshot["userId"],
      gender: snapshot["gender"],
      school: snapshot["school"],
      education: snapshot["education"],
      rollNo: snapshot["rollNo"],
      state: snapshot["state"],
    );
  }

  Map<String, dynamic> toJson() => {
    "grade": grade,
    "uid": uid,
    "userId": userId,
    "gender": gender,
    "school": school,
    "education": education,
    "rollNo": rollNo,
    "state": state,
  };
}
