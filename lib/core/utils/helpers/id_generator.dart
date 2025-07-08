import 'package:uuid/uuid.dart';

class IdGenerator {
  static final Uuid _uuid = Uuid();
  static String get id => _uuid.v4();
}
