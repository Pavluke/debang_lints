import 'package:debang/debang.dart';

Future<void> main() async {
  int? value;
  value.debang('Short message');
  value.debang('Long message which will be without error');
}
