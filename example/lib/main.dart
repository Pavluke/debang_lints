import 'package:debang/debang.dart';

void main() {
  int? value;
  value.debang('Short message');
  value.debang('Long message without author');
  value.debang('(John Doe): Short message');
  value.debang(
      '(John Doe): Long message with author which will be without error');
}
