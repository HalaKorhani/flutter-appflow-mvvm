// Model class representing a predefined user account.
// We use this model to store the username and password for login.
class AppUser {
  final String username;
  final String password;

  // const constructor because predefined users will not change at runtime.
  const AppUser({required this.username, required this.password});
}
