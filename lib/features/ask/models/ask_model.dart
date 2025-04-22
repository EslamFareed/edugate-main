class AskModel {
  final DateTime createdAt;
  final String question;
  final String answer;
  final User user;

  AskModel({
    required this.createdAt,
    required this.question,
    required this.answer,
    required this.user,
  });

  factory AskModel.fromJson(Map<String, dynamic> json) {
    return AskModel(
      createdAt: DateTime.parse(json['createdAt']),
      question: json['question'],
      answer: json['answer'],
      user: User.fromJson(json['user']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdAt': createdAt.toIso8601String(),
      'question': question,
      'answer': answer,
      'user': user.toJson(),
    };
  }
}

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

  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'password': password,
      'gender': gender,
      'nationality': nationality,
      'phone': phone,
      'name': name,
      'dateOfBirth': dateOfBirth,
      'email': email,
    };
  }
}
