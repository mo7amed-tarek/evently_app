import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:evently_app/core/dialog_utils.dart';
import 'package:evently_app/core/firestor_handler.dart';
import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:evently_app/core/resoources/color_manager.dart';
import 'package:evently_app/core/resoources/constants.dart';
import 'package:evently_app/core/resoources/strings_manager.dart';
import 'package:evently_app/core/reusable_components/custom_buttom.dart';
import 'package:evently_app/core/reusable_components/custom_field.dart';
import 'package:evently_app/model/event.dart';
import 'package:evently_app/Ui/home/tabs/map_tab/map_tab.dart';
import 'package:evently_app/Ui/home/tabs/map_tab/provider/maps_tab_provider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';

class CreateEventScreen extends StatefulWidget {
  static const String routeName = "createevent";
  const CreateEventScreen({super.key});

  @override
  State<CreateEventScreen> createState() => _CreateEventScreenState();
}

class _CreateEventScreenState extends State<CreateEventScreen>
    with SingleTickerProviderStateMixin {
  int selectedIndex = 0;
  late TextEditingController titleController;
  late TextEditingController descController;
  late TabController tabController;

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  DateTime? selectedDate;
  TimeOfDay? selectedTime;
  LatLng? selectedLocation;

  @override
  void initState() {
    super.initState();
    titleController = TextEditingController();
    descController = TextEditingController();
    tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    titleController.dispose();
    descController.dispose();
    tabController.dispose();
    super.dispose();
  }

  String formatTime(TimeOfDay time) {
    final now = DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, time.hour, time.minute);
    return DateFormat('hh:mm a').format(dt);
  }

  Future<void> pickLocation() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (_) => ChangeNotifierProvider(
              create: (_) => MapsTabProvider(),
              child: const MapTab(),
            ),
      ),
    );
    if (result != null && result is LatLng) {
      setState(() {
        selectedLocation = result;
      });
    }
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
                    controller: tabController,
                    physics: const NeverScrollableScrollPhysics(),
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
                const SizedBox(height: 16),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: TabBar(
                    controller: tabController,
                    onTap: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    isScrollable: true,
                    dividerHeight: 0,
                    labelPadding: const EdgeInsets.only(right: 10),
                    tabAlignment: TabAlignment.start,
                    unselectedLabelColor: Theme.of(context).colorScheme.primary,
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
                              const SizedBox(width: 10),
                              const Text("Book club"),
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
                              const SizedBox(width: 10),
                              const Text("Sport"),
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
                              const SizedBox(width: 10),
                              const Text("Birthday"),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  StringsManager.titel,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                CustomField(
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return StringsManager.shouldnotempty;
                    }
                    return null;
                  },
                  controller: titleController,
                  hint: StringsManager.eventtitle,
                  prefixpath: AssetsManager.edit,
                  kyboard: TextInputType.text,
                ),
                const SizedBox(height: 16),
                Text(
                  StringsManager.desc,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                CustomField(
                  maxlines: 5,
                  validation: (value) {
                    if (value == null || value.isEmpty) {
                      return StringsManager.shouldnotempty;
                    }
                    return null;
                  },
                  controller: descController,
                  hint: StringsManager.eventdesc,
                  prefixpath: AssetsManager.edit,
                  kyboard: TextInputType.multiline,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    SvgPicture.asset(AssetsManager.calender),
                    const SizedBox(width: 10),
                    Text(
                      StringsManager.eventdate,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () async {
                        final date = await showDatePicker(
                          context: context,
                          firstDate: DateTime.now(),
                          lastDate: DateTime.now().add(
                            const Duration(days: 365),
                          ),
                          initialDate: selectedDate ?? DateTime.now(),
                        );
                        if (date != null) setState(() => selectedDate = date);
                      },
                      child: Text(
                        selectedDate != null
                            ? DateFormat('dd MMM yyyy').format(selectedDate!)
                            : StringsManager.choosedate,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorManager.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Row(
                  children: [
                    SvgPicture.asset(AssetsManager.clock),
                    const SizedBox(width: 10),
                    Text(
                      StringsManager.eventtime,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    const Spacer(),
                    TextButton(
                      onPressed: () async {
                        final time = await showTimePicker(
                          context: context,
                          initialTime: selectedTime ?? TimeOfDay.now(),
                        );
                        if (time != null) setState(() => selectedTime = time);
                      },
                      child: Text(
                        selectedTime != null
                            ? formatTime(selectedTime!)
                            : StringsManager.choosetime,
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: ColorManager.blue,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Text(
                  StringsManager.location,
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const SizedBox(height: 8),
                GestureDetector(
                  onTap: pickLocation,
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
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            selectedLocation != null
                                ? "Lat: ${selectedLocation!.latitude}, Lng: ${selectedLocation!.longitude}"
                                : StringsManager.chooseeventlocation,
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
                const SizedBox(height: 16),
                SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    title: StringsManager.addevent,
                    onClick: () async {
                      if (formKey.currentState!.validate()) {
                        if (selectedDate == null) {
                          DialogUtils.showtoast(StringsManager.chooseeventdate);
                          return;
                        }
                        if (selectedTime == null) {
                          DialogUtils.showtoast(StringsManager.chooseeventtime);
                          return;
                        }
                        if (selectedLocation == null) {
                          DialogUtils.showtoast(
                            StringsManager.chooseeventlocation,
                          );
                          return;
                        }

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
                              title: titleController.text,
                              description: descController.text,
                              favoriteUsers: [],
                              latitude: selectedLocation!.latitude,
                              longitude: selectedLocation!.longitude,
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
    );
  }
}
