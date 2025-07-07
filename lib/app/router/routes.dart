enum Routes {
  home(name: 'home', path: '/home'),
  login(name: 'login', path: '/login'),
  signUp(name: 'singup', path: '/signup'),
  verificationPage(name: "verification", path: "/verification"),
  createProfilePage(name: 'createProfilePage', path: '/createProfilePage');

  final String name;
  final String path;
  const Routes({required this.name, required this.path});
}
