class User {
  bool isValidUser;
  String userName;
  String userVtopId;
  String userEmail;
  String userPhoneNumber;
  String userRole;
  List<String> authorized;
  bool isAdmin;
  String userAdminRole;
  String status;

  User({
    required this.isValidUser,
    required this.userName,
    required this.userVtopId,
    required this.userEmail,
    required this.userPhoneNumber,
    required this.userRole,
    required this.authorized,
    required this.isAdmin,
    required this.userAdminRole,
    required this.status,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      isValidUser: json['isValidUser'] == 'true',
      userName: json['userName'],
      userVtopId: json['userVtopId'],
      userEmail: json['userEmail'],
      userPhoneNumber: json['userPhoneNumber'],
      userRole: json['userRole'],
      authorized: List<String>.from(json['authorized']),
      isAdmin: json['isAdmin'] == 'true',
      userAdminRole: json['userAdminRole'],
      status: json['status'],
    );
  }
}
