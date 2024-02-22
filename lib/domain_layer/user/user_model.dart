class UserModel {
  String? userID;
  String? username;
  String? dialCode;
  String? phoneNumber;

  UserModel({this.userID, this.username, this.dialCode, this.phoneNumber});

  // receive data from server
  factory UserModel.fromMap(map) {
    return UserModel(
        userID: map['userID'],
        username: map['username'],
        dialCode: map['dialCode'],
        phoneNumber: map['phoneNumber']);
  }

  // sending data to server
  Map<String, dynamic> toMap() {
    return {
      'userID': userID,
      'username': username,
      'dialCode': dialCode,
      'phoneNumber': phoneNumber,
    };
  }
}
