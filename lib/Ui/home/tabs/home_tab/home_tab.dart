import 'package:evently_app/Ui/home/tabs/home_tab/widgets/all_tab.dart' as all;
import 'package:evently_app/Ui/home/tabs/home_tab/widgets/birthday_tab.dart'
    as birthday;
import 'package:evently_app/Ui/home/tabs/home_tab/widgets/book_tab.dart'
    as book;
import 'package:evently_app/Ui/home/tabs/home_tab/widgets/sport_tab.dart'
    as sport;
import 'package:evently_app/core/firestor_handler.dart';
import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:evently_app/core/resoources/color_manager.dart';
import 'package:evently_app/core/resoources/strings_manager.dart';
import 'package:evently_app/model/users.dart' as MyUser;
import 'package:evently_app/providers/user_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget {
  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  int selectedIndex = 0;

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
    return DefaultTabController(
      length: 4,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.only(bottom: 16, left: 16, right: 16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(24),
                bottomRight: Radius.circular(24),
              ),
            ),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              StringsManager.welcome,
                              style: Theme.of(
                                context,
                              ).textTheme.labelMedium?.copyWith(
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
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
                            SizedBox(height: 5),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(AssetsManager.sunLight),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: SvgPicture.asset(AssetsManager.enLight),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      SvgPicture.asset(AssetsManager.map),
                      Text(
                        "Tanta , Egypt",
                        style: Theme.of(
                          context,
                        ).textTheme.labelMedium?.copyWith(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 5),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: TabBar(
                      onTap: (index) {
                        setState(() {
                          selectedIndex = index;
                        });
                      },
                      isScrollable: true,
                      dividerHeight: 0,
                      labelPadding: EdgeInsets.only(right: 10),
                      tabAlignment: TabAlignment.start,
                      unselectedLabelColor: Colors.white,
                      labelColor: Theme.of(context).colorScheme.primary,
                      indicator: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      tabs: [
                        _buildTab(
                          Icons.all_inclusive,
                          AssetsManager.all,
                          "All",
                          0,
                        ),
                        _buildTab(Icons.sports, AssetsManager.bike, "Sport", 1),
                        _buildTab(
                          Icons.cake,
                          AssetsManager.cake,
                          "Birthday",
                          2,
                        ),
                        _buildTab(Icons.book, AssetsManager.book, "Books", 3),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              physics: NeverScrollableScrollPhysics(),
              children: [
                all.AllTab(),
                sport.SportTab(),
                birthday.BirthdayTab(),
                book.BookTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(IconData icon, String asset, String label, int index) {
    return Tab(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 17, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              asset,
              colorFilter: ColorFilter.mode(
                selectedIndex == index ? ColorManager.blue : Colors.white,
                BlendMode.srcIn,
              ),
            ),
            SizedBox(width: 10),
            Text(label),
          ],
        ),
      ),
    );
  }
}
