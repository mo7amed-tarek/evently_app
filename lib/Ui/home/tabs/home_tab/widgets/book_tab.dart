import 'package:evently_app/Ui/home/widgets/event_item.dart';
import 'package:evently_app/core/firestor_handler.dart';
import 'package:evently_app/model/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class _EmptyListAnimation extends StatefulWidget {
  const _EmptyListAnimation({Key? key}) : super(key: key);

  @override
  State<_EmptyListAnimation> createState() => _EmptyListAnimationState();
}

class _EmptyListAnimationState extends State<_EmptyListAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _scale = Tween<double>(
      begin: 0.9,
      end: 1.1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ScaleTransition(
      scale: _scale,
      child: Icon(
        Icons.book_outlined,
        size: 120.w,
        color: Colors.grey.shade400,
      ),
    );
  }
}

class BookTab extends StatelessWidget {
  const BookTab({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Event>>(
      stream: FirestorHandler.streamEventsByType('book'),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.data?.isEmpty ?? true) {
          return const Center(child: _EmptyListAnimation());
        }

        final events = snapshot.data!;

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
