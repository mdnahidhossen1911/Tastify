class AuthUserModel {
  String? uid;
  String? fullName;
  String? photo;
  String? email;

  AuthUserModel(
      {
        this.uid,
        this.fullName,
        this.photo,
        this.email});

  AuthUserModel.fromJson(Map<String, dynamic> json) {
    uid = json['id'];
    fullName = json['name'];
    photo = json['photo'];
    email = json['email'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.uid;
    data['name'] = this.fullName;
    data['photo'] = this.photo;
    data['email'] = this.email;
    return data;
  }
}