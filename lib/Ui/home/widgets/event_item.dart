import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:evently_app/core/resoources/color_manager.dart';
import 'package:evently_app/model/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class EventItem extends StatelessWidget {
  final Event event;
  const EventItem(this.event, {super.key});

  @override
  Widget build(BuildContext context) {
    final DateTime safeDate = event.date?.toDate() ?? DateTime.now();

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
                Expanded(child: Text(event.title ?? '')),
                SvgPicture.asset(
                  AssetsManager.heartSelected,
                  colorFilter: ColorFilter.mode(
                    ColorManager.blue,
                    BlendMode.srcIn,
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
    switch (event.type) {
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
