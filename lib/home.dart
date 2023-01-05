import 'package:firebase/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String? imageUrl;
  void checkLogin() {
    imageUrl = FirebaseAuth.instance.currentUser?.photoURL;
  }

  Future<GoogleSignInAccount?> logout() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signOut();
    return googleUser;
  }

  void checkUser() {
    print(FirebaseAuth.instance.currentUser);
  }

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Align(
                alignment: Alignment.center,
              ),
              const Text("PROFILE",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 8, bottom: 10, right: 8, top: 10),
                child: Card(
                  child: ListTile(
                    leading: ClipRRect(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(50)),
                        child: Image.network(imageUrl.toString())),
                    title: const Text("Nanti nama disini"),
                    subtitle: Text(
                        FirebaseAuth.instance.currentUser!.email.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                            onPressed: () async {
                              await logout().then((value) => {Get.to(const MyApp())});
                            },
                            icon: const Icon(Icons.logout))
                      ],
                    ),
                  ),
                ),
              )
              // ElevatedButton(
              //     onPressed: () {
              //       checkUser();
              //     },
              //     child: const Text("Check Login")),
              // ElevatedButton(
              //     onPressed: () async {
              //       await logout().then((value) => {Get.to(const MyApp())});
              //     },
              //     child: const Text("Logout")),
            ],
          ),
        ),
      ),
    );
  }
}
