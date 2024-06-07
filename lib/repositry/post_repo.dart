import 'dart:convert';
import 'dart:developer';

import 'package:api_withgetx/models/post_model.dart';
import 'package:api_withgetx/networking/networking.dart';
import 'package:api_withgetx/utills/api_urls.dart';

class PostRepositry extends ApiService {
  List<PostsModel> posts = [];

  //get all posts
  Future getAllposts() async {
    final response = await getHttp(api: ApiUrls.post, token: false);
    log(response.body, name: 'getPostApi');
    return jsonDecode(response.body);
  }

  //get all posts
  Future getUsers() async {
    final response = await getHttp(api: ApiUrls.user, token: false);
    log(response.body, name: 'getUserApi');
    return jsonDecode(response.body);
  }

  // get particular users
  Future getParicularUsers(String id) async {
    final params = '/$id';
    final response = await getHttp(api: ApiUrls.user + params, token: false);
    log(response.body, name: 'getParicularusers');
    return jsonDecode(response.body);
  }
}
