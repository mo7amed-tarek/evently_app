class User {
  String? id;
  String? name;
  String? gender;
  String? email;
  String? profileImage;

  User({this.id, this.name, this.gender, this.email, this.profileImage});
  User.fromefirestor(Map<String, dynamic>? data) {
    id = data?["id"];
    name = data?["name"];
    gender = data?["gender"];
    email = data?["email"];
    profileImage = data?["profileImage"];
  }
  Map<String, dynamic> tofirestor() {
    return {
      "id": id,
      "name": name,
      "gender": gender,
      "email": email,
      "profileImage": profileImage,
    };
  }
}
