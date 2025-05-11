import 'package:evently_app/core/resoources/color_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomField extends StatelessWidget {
  final String? Function(String?)? validation;
  final String hint;
  final String prefixpath;
  final TextEditingController controller;
  final TextInputType kyboard;
  final bool obscure;

  const CustomField({
    super.key,
    required this.validation,
    required this.controller,
    required this.hint,
    required this.prefixpath,
    required this.kyboard,
    this.obscure = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validation,
      controller: controller,
      style: Theme.of(context).textTheme.titleSmall,
      keyboardType: kyboard,
      obscureText: obscure,
      obscuringCharacter: "*",
      decoration: InputDecoration(
        hintStyle: Theme.of(context).textTheme.titleSmall,
        hintText: hint,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorManager.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorManager.grey),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorManager.grey),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(color: ColorManager.grey),
        ),
        prefixIconConstraints: BoxConstraints(maxHeight: 80.h, maxWidth: 80.w),
        prefixIcon: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 19),
          child: SvgPicture.asset(
            prefixpath,
            height: 32.h,
            width: 32.w,
            colorFilter: ColorFilter.mode(
              Theme.of(context).colorScheme.onPrimaryContainer,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
