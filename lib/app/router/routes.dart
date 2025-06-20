enum Routes {
  home(name: 'home', path: '/home'),
  signup(name: 'signup', path: '/signup'),
  login(name: 'login', path: '/login'),
  profileCreation(name: 'profileCreation', path: '/profileCreation');

  final String name;
  final String path;
  const Routes({required this.name, required this.path});
}
