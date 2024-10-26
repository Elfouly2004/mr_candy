class UserModelToRegister{

  final String name;
  final String email;
  final String phone;
  final String image;
  final String password;

  UserModelToRegister({required this.name, required this.email, required this.phone, required this.image, required this.password});


  Map<String,dynamic> toJson(  ) {
    return {
      "name": name,
      "phone": phone,
      "email": email,
      "password": password,
      "image": image
    };
  }


}