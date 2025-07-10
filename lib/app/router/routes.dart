enum Routes {
  home(name: 'home', path: '/home'),
  login(name: 'login', path: '/login'),
  signUp(name: 'singup', path: '/signup'),
  verificationPage(name: "verification", path: "/verification"),
  profilePageGateway(name: "profilePageGateway", path: "/profilePageGateway"),
  createProfilePage(name: 'createProfilePage', path: '/createProfilePage'),
  profilePage(name: 'profilePage', path: "/profilePage"),
  transactionsPage(name: 'transactionsPage', path: '/transactionsPage'),
  statisticsPage(name: 'statisticsPage', path: '/statisticsPage');

  final String name;
  final String path;
  const Routes({required this.name, required this.path});
}
