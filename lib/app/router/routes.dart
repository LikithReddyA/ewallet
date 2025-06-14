enum Routes {
  home(name: 'home', path: '/home'),
  signup(name: 'signup', path: '/signup'),
  login(name: 'login', path: '/login');

  final String name;
  final String path;
  const Routes({required this.name, required this.path});
}
