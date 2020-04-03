class RegPopulateFields {
  static List<Map<String, String>> _form = [
    {
      'name': "Aleks",
      'email': "aleksej.lobikov@gmail.com",
      'password': "qwerty",
      'confirmPassword': "qwerty",
    },
    {
      'name': "Mario",
      'email': "mario@yahoo.com",
      'password': "asdfgh",
      'confirmPassword': "asdfgh",
    },
    {
      'name': "Petras",
      'email': "petras@mail.ru",
      'password': "p12345",
      'confirmPassword': "p12345",
    },
    {
      'name': "",
      'email': "",
      'password': "",
      'confirmPassword': "",
    },
  ];

  RegPopulateFields.next()
      : this._name = _form[_currentMockUserId]['name'],
        this._email = _form[_currentMockUserId]['email'],
        this._password = _form[_currentMockUserId]['password'],
        this._confirmPassword = _form[_currentMockUserId]['confirmPassword'] {
    _advanceToNextUser();
  }
  static int _currentMockUserId = 0;

  final String _name;
  final String _email;
  final String _password;
  final String _confirmPassword;

  String get name => _name;
  String get email => _email;
  String get password => _password;
  String get confirmPassword => _confirmPassword;

  static void _advanceToNextUser() {
    _currentMockUserId = ++_currentMockUserId % _form.length;
  }
}
