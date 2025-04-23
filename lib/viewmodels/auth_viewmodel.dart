class AuthViewmodel {
  AuthViewmodel._konstruktor();
  static final AuthViewmodel object = AuthViewmodel._konstruktor();
  factory AuthViewmodel() {
    return object;
  }

  String authId = '';
}
