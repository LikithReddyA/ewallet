enum Routes {
  home(name: 'home', path: '/home'),
  login(name: 'login', path: '/login');

  final String name;
  final String path;
  const Routes({required this.name, required this.path});
}
