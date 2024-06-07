import 'package:api_withgetx/controller/user_controller.dart';
import 'package:api_withgetx/models/user_model.dart';
import 'package:api_withgetx/utills/app_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserScreen extends StatefulWidget {
  final int id;

  const UserScreen({
    super.key,
    required this.id,
  });

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  // late PostProvider provider;
  UserModel? user;

  UserController userController = Get.put(UserController());
  @override
  void initState() {
    userController.getParticulatUsers(widget.id.toString());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        title: Image.asset(
          AppLogos.twitterLogo,
          cacheHeight: 30,
          cacheWidth: 30,
        ),
        centerTitle: true,
        leading: const Icon(
          Icons.person_outline,
          color: Colors.black,
          size: 30,
        ),
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.notifications_outlined,
              color: Colors.black,
              size: 30,
            ),
          ),
        ],
      ),
      body: Obx(() {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: ListView.builder(
              itemCount: userController.userDetail.length,
              itemBuilder: (context, index) {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildHeader(user),
                      const SizedBox(height: 16.0),
                      _buildContactInfo(user),
                      const SizedBox(height: 16.0),
                      _buildAddress(user),
                      const SizedBox(height: 16.0),
                      _buildCompanyInfo(user),
                    ],
                  ),
                );
              }),
        );
      }),
    );
  }
}

Widget _buildHeader(UserModel? user) {
  return Row(
    children: [
      const CircleAvatar(
        radius: 40,
        child: Icon(Icons.person, size: 60),
      ),
      const SizedBox(width: 16.0),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            user!.name ?? '',
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            '@${user.username}',
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
        ],
      ),
    ],
  );
}

Widget _buildContactInfo(UserModel? user) {
  return Card(
    borderOnForeground: false,
    elevation: 2.0,
    shadowColor: Colors.redAccent,
    surfaceTintColor: Colors.pinkAccent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    clipBehavior: Clip.none,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Contact Info',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Icon(Icons.email, color: Colors.blue),
              const SizedBox(width: 8.0),
              Text(user!.email ?? 'no email'),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Icon(Icons.phone, color: Colors.blue),
              const SizedBox(width: 8.0),
              Text(user.phone ?? 'no phone'),
            ],
          ),
          const SizedBox(height: 8.0),
          Row(
            children: [
              const Icon(Icons.web, color: Colors.blue),
              const SizedBox(width: 8.0),
              Text(user.website ?? ' no website'),
            ],
          ),
        ],
      ),
    ),
  );
}

Widget _buildAddress(UserModel? user) {
  final address = user!.address;
  return Card(
    borderOnForeground: false,
    elevation: 2.0,
    shadowColor: Colors.redAccent,
    surfaceTintColor: Colors.pinkAccent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    clipBehavior: Clip.none,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Address',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(
              '${address!.street ?? 'no street'}, ${address.suite ?? 'no suite'}'),
          Text('${address.city}, ${address.zipcode}'),
        ],
      ),
    ),
  );
}

Widget _buildCompanyInfo(UserModel? user) {
  final company = user!.company;
  return Card(
    borderOnForeground: false,
    elevation: 2.0,
    shadowColor: Colors.redAccent,
    surfaceTintColor: Colors.pinkAccent,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(30.0),
    ),
    clipBehavior: Clip.none,
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Company',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          Text(company!.name ?? 'no name'),
          const SizedBox(height: 8.0),
          Text('Catch Phrase: ${company.catchPhrase}'),
          const SizedBox(height: 8.0),
          Text('BS: ${company.bs}'),
        ],
      ),
    ),
  );
}
