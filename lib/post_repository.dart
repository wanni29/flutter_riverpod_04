import 'package:dio/dio.dart';
import 'package:flutter_riverpod_04/post_view_model.dart';

class PostRepository {
  Dio dio = Dio();

  Future<PostModel> fetchPost(int id) async {
    // 1. 통신
    final reponse =
        await dio.get("https://jsonplaceholder.typicode.com/posts/${id}");

    // 2. 파싱
    PostModel postModel = PostModel.fromJson(reponse.data);

    // 3. 리턴
    return postModel;
  }
}
