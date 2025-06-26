import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:evently_app/core/dialog_utils.dart';
import 'package:evently_app/core/firestor_handler.dart';
import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:evently_app/core/resoources/color_manager.dart';
import 'package:evently_app/core/resoources/constants.dart';
import 'package:evently_app/core/resoources/strings_manager.dart';
import 'package:evently_app/core/reusable_components/custom_buttom.dart';
import 'package:evently_app/core/reusable_components/custom_field.dart';
import 'package:evently_app/model/event.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = "createevent";
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen> {
  int selectedIndex = 0;
  late TextEditingController titleControler;
  late TextEditingController descControler;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;

  @override
  void initState() {
    super.initState();
    titleControler = TextEditingController();
    descControler = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    titleControler.dispose();
    descControler.dispose();
  }

  String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          StringsManager.createEvent,
          style: Theme.of(context).appBarTheme.titleTextStyle?.copyWith(
            color: Theme.of(context).colorScheme.primary,
          ),
        ),
        foregroundColor: Theme.of(context).colorScheme.primary,
      ),
      body: SingleChildScrollView(
        child: DefaultTabController(
          length: 3,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 203.h,
                    child: TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            AssetsManager.bookclub,
                            width: double.infinity,
                            height: 203.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            AssetsManager.sport,
                            width: double.infinity,
                            height: 203.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(16),
                          child: Image.asset(
                            AssetsManager.birthday,
                            width: double.infinity,
                            height: 203.h,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16),
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
                      unselectedLabelColor:
                          Theme.of(context).colorScheme.primary,
                      labelColor: Colors.white,
                      indicator: BoxDecoration(
                        color: Theme.of(context).colorScheme.primary,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      tabs: [
                        Tab(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 17,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorManager.blue),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AssetsManager.book,
                                  colorFilter: ColorFilter.mode(
                                    selectedIndex == 0
                                        ? Colors.white
                                        : ColorManager.blue,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text("Book club"),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 17,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorManager.blue),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AssetsManager.bike,
                                  colorFilter: ColorFilter.mode(
                                    selectedIndex == 1
                                        ? Colors.white
                                        : ColorManager.blue,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 10),
                                Text("Sport"),
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 17,
                              vertical: 10,
                            ),
                            decoration: BoxDecoration(
                              border: Border.all(color: ColorManager.blue),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  AssetsManager.cake,
                                  colorFilter: ColorFilter.mode(
                                    selectedIndex == 2
                                        ? Colors.white
                                        : ColorManager.blue,
                                    BlendMode.srcIn,
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text("Birthday"),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    StringsManager.titel,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 8.h),
                  CustomField(
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManager.shouldnotempty;
                      }
                      return null;
                    },
                    controller: titleControler,
                    hint: StringsManager.eventtitle,
                    prefixpath: AssetsManager.edit,
                    kyboard: TextInputType.text,
                  ),
                  SizedBox(height: 16),
                  Text(
                    StringsManager.desc,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 8.h),
                  CustomField(
                    maxlines: 5,
                    validation: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManager.shouldnotempty;
                      }
                      return null;
                    },
                    controller: descControler,
                    hint: StringsManager.eventdesc,
                    prefixpath: "",
                    kyboard: TextInputType.multiline,
                  ),
                  SizedBox(height: 16),
                  Row(
                    children: [
                      SvgPicture.asset(AssetsManager.calender),
                      SizedBox(width: 10.w),
                      Text(
                        StringsManager.eventdate,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () async {
                          var data = await showDatePicker(
                            context: context,
                            firstDate: DateTime.now(),
                            lastDate: DateTime.now().add(Duration(days: 365)),
                            initialDate: selectedDate ?? DateTime.now(),
                          );
                          if (data != null) {
                            setState(() {
                              selectedDate = data;
                            });
                          }
                        },
                        child: Text(
                          selectedDate != null
                              ? DateFormat('dd MMM yyyy').format(selectedDate!)
                              : StringsManager.choosedate,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: ColorManager.blue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 2),
                  Row(
                    children: [
                      SvgPicture.asset(AssetsManager.clock),
                      SizedBox(width: 10.w),
                      Text(
                        StringsManager.eventtime,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      Spacer(),
                      TextButton(
                        onPressed: () async {
                          final TimeOfDay? time = await showTimePicker(
                            context: context,
                            initialTime: selectedTime ?? TimeOfDay.now(),
                          );
                          if (time != null) {
                            setState(() {
                              selectedTime = time;
                            });
                          }
                        },
                        child: Text(
                          selectedTime != null
                              ? formatTime(selectedTime!)
                              : StringsManager.choosetime,
                          style: Theme.of(context).textTheme.bodySmall
                              ?.copyWith(color: ColorManager.blue),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Text(
                    StringsManager.location,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                  SizedBox(height: 8.h),
                  GestureDetector(
                    onTap: () {
                      // Navigate to location picker
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 12.h,
                      ),
                      decoration: BoxDecoration(
                        color: ColorManager.blue.withOpacity(0.05),
                        border: Border.all(color: ColorManager.blue),
                        borderRadius: BorderRadius.circular(16.r),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(10.w),
                            decoration: BoxDecoration(
                              color: ColorManager.blue,
                              borderRadius: BorderRadius.circular(12.r),
                            ),
                            child: SvgPicture.asset(AssetsManager.location),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              StringsManager.chooseeventlocation,
                              style: TextStyle(
                                color: ColorManager.blue,
                                fontSize: 14.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          Icon(
                            Icons.arrow_forward_ios,
                            color: ColorManager.blue,
                            size: 18.sp,
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),
                  SizedBox(
                    width: double.infinity,
                    child: CustomButton(
                      title: StringsManager.addevent,
                      onClick: () async {
                        if (formKey.currentState!.validate()) {
                          if (selectedDate == null) {
                            DialogUtils.showtoast(
                              StringsManager.chooseeventdate,
                            );
                            return;
                          }
                          if (selectedTime == null) {
                            DialogUtils.showtoast(
                              StringsManager.chooseeventtime,
                            );
                            return;
                          }
                          //add event
                          DateTime eventDate = DateTime(
                            selectedDate!.year,
                            selectedDate!.month,
                            selectedDate!.day,
                            selectedTime!.hour,
                            selectedTime!.minute,
                          );
                          DialogUtils.showLodingDialog(context);
                          try {
                            await FirestorHandler.addEvent(
                              Event(
                                type: eventTypes[selectedIndex],
                                userId: FirebaseAuth.instance.currentUser!.uid,
                                date: Timestamp.fromDate(eventDate),
                                title: titleControler.text,
                                description: descControler.text,
                                favoriteUsers: [],
                                latitude: 30.0444,
                                longitude: 30.0444,
                              ),
                            );
                            Navigator.pop(context);
                            DialogUtils.showtoast(StringsManager.eventadded);
                          } catch (e) {
                            Navigator.pop(context);
                            DialogUtils.showtoast(e.toString());
                          }
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
