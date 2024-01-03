class LogInUser {
  LogInUser(
      {this.email,
        this.password,
        this.token,
        this.login_by,
        this.device_type,
        this.name,
        this.bio,
        this.profilePicture,
        this.coverPicture,
        this.userId});

  String? email;
  String? password;
  String? token;
  String? profilePicture;
  String? coverPicture;
  String? name;
  String? bio;
  String? login_by;
  String? device_type;
  String? userId;

  factory LogInUser.fromJson(Map<String, dynamic> json) => LogInUser(
    password: json["password"],
    email: json["email"],
    login_by: json["loginBy"],
    device_type: json["device_type"],
  );

  Map<String, dynamic> toJson() => {
    "password": password,
    "email": email,
    "login_by": login_by,
    "device_type": device_type,
  };
}
