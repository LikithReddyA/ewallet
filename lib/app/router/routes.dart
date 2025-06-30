enum Routes {
  home(name: 'home', path: '/home');

  final String name;
  final String path;
  const Routes({required this.name, required this.path});
}
