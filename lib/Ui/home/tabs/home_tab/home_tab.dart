import 'package:evently_app/core/firestor_handler.dart';
import 'package:evently_app/core/resoources/color_manager.dart';
import 'package:evently_app/model/users.dart' as MyUser;
import 'package:evently_app/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    getFirestoreUser();
  }

  getFirestoreUser() async {
    UserProvider provider = Provider.of<UserProvider>(context, listen: false);
    if (provider.myUser == null) {
      MyUser.User? user = await FirestorHandler.getUser(
        FirebaseAuth.instance.currentUser?.uid ?? "",
      );
      provider.savaUser(user);
    }
  }

  @override
  Widget build(BuildContext context) {
    UserProvider provider = Provider.of<UserProvider>(context);
    return Scaffold(
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 175.h,
            decoration: BoxDecoration(
              color: ColorManager.blue,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: Center(
              child:
                  provider.myUser == null
                      ? CircularProgressIndicator(color: Colors.white)
                      : Text(
                        provider.myUser?.name ?? "",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 22.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
            ),
          ),
        ],
      ),
    );
  }
}
