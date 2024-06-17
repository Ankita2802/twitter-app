import 'dart:developer';
import 'package:api_withgetx/models/post_model.dart';
import 'package:api_withgetx/models/user_model.dart';
import 'package:api_withgetx/repositry/post_repo.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  PostRepositry repo = PostRepositry();
  Rx<UserModel> users = UserModel().obs;
  RxList<UserModel> user = <UserModel>[].obs;
  RxList<UserModel> userDetail = <UserModel>[].obs;
  RxList<PostsModel> post = <PostsModel>[].obs;

  /// get All users
  Future<void> getUsers() async {
    try {
      final response = await repo.getUsers();
      log(response.toString(), name: 'getUsers');
      response.forEach((element) {
        user.add(UserModel.fromJson(element));
      });

      log(user.toString(), name: 'users');
    } catch (e, s) {
      log(e.toString(), name: 'error getUsers', stackTrace: s);
    }
  }

  // Get particular user
  Future<void> getParticulatUsers(String id) async {
    try {
      log('Fetching user with id: $id', name: 'getParticulatUsers');
      final response = await repo.getParicularUsers(id);
      userDetail.clear();
      log('Response received: ${response.toString()}',
          name: 'getParticulatUsers');
      userDetail.add(UserModel.fromJson(
          response)); // Add the single user object to the list
    } catch (e, s) {
      log('Error occurred: ${e.toString()}',
          name: 'error getParticulatUsers', stackTrace: s);
    }
  }
}
