import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:parse_server_sdk/parse_server_sdk.dart';
import 'package:web_notify/models/user.dart';
import 'package:web_notify/constants/key.dart' as keys;


class ParseServices {

  Parse parseInstance;

  Future<String> initParse() async {
    print('Initializing Back4App...');
    parseInstance = await Parse().initialize(
      keys.PARSE_APP_ID, keys.PARSE_APP_URL,
      // masterKey: MASTER_KEY,
      clientKey: keys.CLIENT_KEY,
      liveQueryUrl: keys.LIVE_QUERY_URL,
      autoSendSessionId: true,
      debug: true,
      // coreStore: await CoreStoreSharedPrefsImp.getInstance(),
    );

    // var dietPlan = ParseObject('DietPlan')
    //   ..set('Name', 'Ketogenic')
    //   ..set('Fat', 65);
    // await dietPlan.save();
    // print('init complete');

    var response = await Parse().healthCheck(debug: true);
    if (response.success) {
      print('Back4app server is OK');
    } else {
      print("Server health check failed");
    }
    return 'initParse() is complete';
  }

  test() async {
    var api =
        "https://www.thecocktaildb.com/api/json/v1/1/filter.php?c=Cocktail";
    var res = await http.get(api);
    var drinks = jsonDecode(res.body)["drinks"];
    print(drinks.toString());
  }

  loginTest() async {

  }

  /// returns null if success or error message
  Future<String> login(IamUser usr) async {
    var user = ParseUser(
      usr.username,
      usr.password,
      usr.email,
    ); // create user object
    ParseResponse response = await user.login();
    if (response.success) {
      user = response.result;
      // form.setField({'objectId': user.objectId});
      print('objectId: ${user.objectId}');
      return null;
    } else {
      return response.error.message;
    }
  }

  /// returns null if success or error message
  Future<String> signout(IamUser usr) async {
    print('parse_services signout');
    var user = ParseUser(
      usr.username,
      usr.password,
      usr.email,
    ); // create user object
    if (user != null) {
      // only if user logged in then logout
      var response = await user.logout();
      if (response.success)
        print('User logout success');
      else {
        print('User logout success');
        return response.error.message; }
    }
    return null;
  }

  /// returns null if success or error message
  Future<String> signup(IamUser usr) async {
    // first, create user object
    var user = ParseUser(
      usr.username,
      usr.password,
      usr.email,
    );
    ParseResponse response = await user.signUp();
    if (response.success) {
      user = response.result;
      usr.objectId = user.objectId;
      print('objectId: ${user.objectId}');
      await _createSelfUser(usr); // fill out Users collection
      return null;
    } else {
      return response.error.message;
    }
  }

  /// Checks state of current user in Back4App
  /// 
  /// returns null or AuthUser
  Future<AuthUser> isLogged() async {
    var user = await ParseUser.currentUser();
    // Update current user from server - Best done to verify user is still a valid user
    var response = await ParseUser.getCurrentUserFromServer();
    // user?.get<String>(keyHeaderSessionToken)); //? newer lib parameters
    if (response?.success ?? false) {
      user = response.result;
      print('isLogged(): ${user['username']}');
      return AuthUser.fromJson(user);
    }
    print('isLogged(): user not logged');
    return null;
  }

  /// creates record of this.user in Users on b4a
  _createSelfUser(form) async {
    String deviceid = 'none'; // await DeviceId.getID;
    var usersNewObject = ParseObject('Users')
      ..set<String>('deviceId', deviceid)
      ..set<String>('userObjId', form.objectId)
      ..set<String>('username', form.name);
    var response = await usersNewObject.create();
    if (response.success && response.result != null)
      print('User recorded in "Users" collection');
    else
      print('Users collection upfdate failed');
    return null;
  }
}
