import 'package:flutter_riverpod/flutter_riverpod.dart';

// 창고 데이터
class SessionUser {
  bool isLogin;

  SessionUser({this.isLogin = false});
}

// 창고 관리자
final sessionProvider = Provider<SessionUser>((ref) {
  return SessionUser();
});
