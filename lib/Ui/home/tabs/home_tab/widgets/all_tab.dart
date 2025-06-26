import 'package:evently_app/Ui/home/widgets/event_item.dart';
import 'package:evently_app/core/firestor_handler.dart';
import 'package:evently_app/model/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';

class AllTab extends StatelessWidget {
  const AllTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Event>>(
      future: FirestorHandler.getEventsByType('all'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (snapshot.data?.isEmpty ?? true) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Lottie.asset(
                  'assets/animations/empty.json',
                  width: 200.w,
                  height: 200.h,
                ),
                SizedBox(height: 16.h),
                Text(
                  'No events found',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          );
        }

        final events = snapshot.data ?? const <Event>[];

        return ListView.separated(
          padding: EdgeInsets.all(16.w),
          itemCount: events.length,
          separatorBuilder: (_, __) => SizedBox(height: 12.h),
          itemBuilder: (context, index) => EventItem(events[index]),
        );
      },
    );
  }
}
