/// singleton with user properties
class IamUser {
  IamUser._privateconstructor();
  static final IamUser _instance = IamUser._privateconstructor();
  factory IamUser() {
    return _instance;
  }
  String username;
  String email;
  String password;
  String objectId;
  String deviceId;

  void fromJson(data) {
    username = data['name'];
    email = data['email'];
    password = data['password'];
    // objectId ??= data['objectId'];
    // deviceId ??= data['deviceId'];
  }

  @override
  String toString() {
    return 'IamUser(): $username $email $password $deviceId $objectId';
  }
}
