import 'package:edugate/features/home/models/major_model.dart';
import 'package:edugate/features/home/models/university_model.dart';

class User {
  final String uid;
  final String password;
  final String gender;
  final String nationality;
  final String phone;
  final String name;
  final String dateOfBirth;
  final String email;

  User({
    required this.uid,
    required this.password,
    required this.gender,
    required this.nationality,
    required this.phone,
    required this.name,
    required this.dateOfBirth,
    required this.email,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      uid: json['uid'],
      password: json['password'],
      gender: json['gender'],
      nationality: json['nationality'],
      phone: json['phone'],
      name: json['name'],
      dateOfBirth: json['dateOfBirth'],
      email: json['email'],
    );
  }
}

class StudentApplication {
  final DateTime date;
  final String motherPhone;
  final String fatherJob;
  final UniversityModel university;
  final String motherName;
  final String idNumber;
  final String type;
  final String highSchoolName;
  final String motherJob;
  final Major major;
  final String highSchoolPercentage;
  final String fatherPhone;
  final String idPhoto;
  final User user;
  final String certificatePhoto;
  final String status;
  final String interviewDate;
  final String interviewDesc;

  StudentApplication({
    required this.date,
    required this.motherPhone,
    required this.fatherJob,
    required this.university,
    required this.motherName,
    required this.idNumber,
    required this.type,
    required this.highSchoolName,
    required this.motherJob,
    required this.major,
    required this.highSchoolPercentage,
    required this.fatherPhone,
    required this.idPhoto,
    required this.user,
    required this.certificatePhoto,
    required this.status,
    required this.interviewDate,
    required this.interviewDesc,
  });

  factory StudentApplication.fromJson(Map<String, dynamic> json) {
    return StudentApplication(
      date: DateTime.parse(json['date']),
      motherPhone: json['motherPhone'],
      fatherJob: json['fatherJob'],
      university: UniversityModel.fromJson(json['university']),
      motherName: json['motherName'],
      idNumber: json['idNumber'],
      type: json['type'],
      highSchoolName: json['highSchoolName'],
      motherJob: json['motherJob'],
      major: Major.fromJson(json['major']),
      highSchoolPercentage: json['highSchoolPercentage'],
      fatherPhone: json['fatherPhone'],
      idPhoto: json['idPhoto'],
      user: User.fromJson(json['user']),
      certificatePhoto: json['certificatePhoto'],
      status: json['status'],
      interviewDesc: json['interviewDesc'],
      interviewDate: json['interviewDate'],
    );
  }
}
