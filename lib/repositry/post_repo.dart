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

  /// post id remove

  Future postRemove(String id) async {
    final params = '/$id';
    final response = await deleteHttp(api: ApiUrls.post + params, token: false);
    log(response.body, name: 'Post Delete Api');
    return jsonDecode(response.body);
  }

  //get all posts
  Future getUsers() async {
    final response = await getHttp(api: ApiUrls.user, token: false);
    log(response.body, name: 'getUserApi');
    return jsonDecode(response.body);
  }

  // get particular users
  Future<Map<String, dynamic>> getParicularUsers(String id) async {
    final params = '/$id';
    final response = await getHttp(api: ApiUrls.user + params, token: false);

    log(response.body, name: 'getParicularusers');
    if (response.statusCode == 200) {
      log('Successfully fetched user data', name: 'UserRepository');
      return json.decode(response.body) as Map<String, dynamic>;
    } else {
      log('Failed to fetch user. Status code: ${response.statusCode}',
          name: 'UserRepository');
      throw Exception('Failed to fetch user');
    }
  }

  //get particaul user commets
  Future comments(int postId) async {
    final params = '?postId=$postId';
    log(params.toString(), name: 'Parameter');
    final response = await getHttp(api: ApiUrls.comment + params, token: false);
    log(response.body, name: 'get Commets');
    return jsonDecode(response.body);
  }
}
