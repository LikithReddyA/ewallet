class CreateAccountParams {
  final String email;
  final String password;

  final String? displayName;
  final String? photoUrl;

  CreateAccountParams({
    required this.email,
    required this.password,
    this.displayName,
    this.photoUrl,
  });
}
