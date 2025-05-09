import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';

class CustomSwitch extends StatelessWidget {
  final String item1;
  final String item2;
  final bool isColord;
  final int selected;
  final FutureOr<void> Function(int)? onChanged;

  const CustomSwitch({
    Key? key,
    required this.item1,
    required this.item2,
    required this.isColord,
    required this.selected,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40.h,
      width: 80.w,
      child: AnimatedToggleSwitch<int>.rolling(
        current: selected,
        values: [0, 1],
        iconList: [
          SvgPicture.asset(
            item1,
            height: 30.h,
            width: 30.w,
            colorFilter:
                isColord
                    ? ColorFilter.mode(
                      selected == 0
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    )
                    : null,
          ),

          SvgPicture.asset(
            item2,
            height: 30.h,
            width: 30.w,
            colorFilter:
                isColord
                    ? ColorFilter.mode(
                      selected == 1
                          ? Theme.of(context).colorScheme.onPrimary
                          : Theme.of(context).colorScheme.primary,
                      BlendMode.srcIn,
                    )
                    : null,
          ),
        ],
        iconOpacity: 1,
        inactiveOpacity: 1,
        style: ToggleStyle(
          borderColor: Theme.of(context).colorScheme.primary,
          indicatorColor: Theme.of(context).colorScheme.primary,
        ),
        onChanged: onChanged,
      ),
    );
  }
}
