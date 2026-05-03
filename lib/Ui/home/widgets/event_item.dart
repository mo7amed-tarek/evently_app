import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/Ui/home/widgets/event_details_screen.dart';
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

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => EventDetailsScreen(event: widget.event),
          ),
        );
      },
      child: Container(
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
              padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    DateFormat.MMM().format(safeDate),
                    style: TextStyle(
                      color: ColorManager.blue,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
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
                  Expanded(
                    child: Text(
                      widget.event.title ?? '',
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      final uid = FirebaseAuth.instance.currentUser!.uid;

                      if (widget.event.favoriteUsers?.contains(uid) ?? false) {
                        widget.event.favoriteUsers?.remove(uid);
                        await FirestorHandler.removefavoriteEvent(
                          uid,
                          widget.event,
                        );
                      } else {
                        widget.event.favoriteUsers?.add(uid);
                        await FirestorHandler.addfavoriteEvent(
                          uid,
                          widget.event,
                        );
                      }

                      await FirestorHandler.updateEventFavorite(widget.event);

                      if (mounted) setState(() {});
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
