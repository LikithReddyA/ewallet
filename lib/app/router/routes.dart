enum Routes {
  home(name: 'home', path: '/home'),
  login(name: 'login', path: '/login'),
  signUp(name: 'singup', path: '/signup');

  final String name;
  final String path;
  const Routes({required this.name, required this.path});
}
