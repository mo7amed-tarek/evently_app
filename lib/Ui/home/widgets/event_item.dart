import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/firestor_handler.dart';
import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:evently_app/core/resoources/color_manager.dart';
import 'package:evently_app/model/event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventItem extends StatefulWidget {
  final Event event;
  const EventItem(this.event, {super.key});

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {
  @override
  Widget build(BuildContext context) {
    final DateTime safeDate = widget.event.date?.toDate() ?? DateTime.now();

    return Container(
      padding: const EdgeInsets.all(8),
      height: 200.h,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: AssetImage(_checkEventImage()),
          fit: BoxFit.fill,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.symmetric(vertical: 1.h, horizontal: 5.w),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              children: [
                Text(
                  DateFormat.d().format(safeDate),
                  style: TextStyle(
                    color: ColorManager.blue,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  DateFormat.MMM().format(safeDate),
                  style: TextStyle(
                    color: ColorManager.blue,
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 10.h),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Expanded(child: Text(widget.event.title ?? '')),
                InkWell(
                  onTap: () async {
                    if (widget.event.favoriteUsers?.contains(
                          FirebaseAuth.instance.currentUser!.uid,
                        ) ??
                        false) {
                      widget.event.favoriteUsers?.remove(
                        FirebaseAuth.instance.currentUser!.uid,
                      );
                      await FirestorHandler.removefavoriteEvent(
                        FirebaseAuth.instance.currentUser!.uid,
                        widget.event,
                      );
                      await FirestorHandler.updateEventFavorite(widget.event);
                      if (mounted) {
                        setState(() {});
                      }
                    } else {
                      widget.event.favoriteUsers?.add(
                        FirebaseAuth.instance.currentUser!.uid,
                      );
                      await FirestorHandler.addfavoriteEvent(
                        FirebaseAuth.instance.currentUser!.uid,
                        widget.event,
                      );
                      await FirestorHandler.updateEventFavorite(widget.event);
                      if (mounted) {
                        setState(() {});
                      }
                    }
                  },
                  child: SvgPicture.asset(
                    widget.event.favoriteUsers?.contains(
                              FirebaseAuth.instance.currentUser!.uid,
                            ) ??
                            false
                        ? AssetsManager.heartSelected
                        : AssetsManager.heart,
                    colorFilter: ColorFilter.mode(
                      ColorManager.blue,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _checkEventImage() {
    switch (widget.event.type) {
      case 'sport':
        return AssetsManager.sport;
      case 'book':
        return AssetsManager.bookclub;
      case 'birthday':
        return AssetsManager.birthday;
      default:
        return AssetsManager.birthday;
    }
  }
}
