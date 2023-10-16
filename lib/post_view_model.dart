// 1. 창고 데이터 (Model)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod_04/post_repository.dart';
import 'package:flutter_riverpod_04/session_provider.dart';

class PostModel {
  int id;
  int userId;
  String title;

  PostModel(this.id, this.userId, this.title);

  PostModel.fromJson(Map<String, dynamic> json)
      : this.id = json["id"],
        this.userId = json["userId"],
        this.title = json["title"];
} // 이니셜라이즈 한번 더 보기!

// 2. 창고 (ViewModel)
class PostViewModel extends StateNotifier<PostModel?> {
  // 생성자를 통해 상태를 부모에게 전달
  PostViewModel(super.state, this.ref);

  Ref ref;

  // 상태 초기화(필수)
  void init() async {
    PostModel postModel = await PostRepository().fetchPost(40);
    state = postModel;
  }

  // 상태 변경 (로그인 했을때? 안했을때?)
  void change() async {
    SessionUser sessionUser = ref.read(sessionProvider);

    if (sessionUser.isLogin) {
      PostModel postModel = await PostRepository().fetchPost(50);
      state = postModel;
    }
  }
}

// 3. 창고 관리자 (Provider)
final postProvider =
    StateNotifierProvider.autoDispose<PostViewModel, PostModel?>((ref) {
  return PostViewModel(null, ref)..init();

  // autoDispose -> RequestSetAttribute와 거의 동일한거임
  // 다쓰고 나면 플러터라는 얘가 " 이 자원은 더이상 쓰지않는구나, 삭제할게 "
  // 알아서 자원의 누유를 막아쥼
});
