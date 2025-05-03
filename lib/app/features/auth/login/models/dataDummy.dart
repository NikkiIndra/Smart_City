class UserModel {
  final String email;
  final String password;

  UserModel({required this.email, required this.password});
}

class DataDummy {
  static List<UserModel> users = [
    UserModel(email: "nikki@example.com", password: "A123456@"),
    UserModel(email: "indra@example.com", password: "B123456@"),
    UserModel(email: "putra@example.com", password: "C123456@"),
  ];
}
