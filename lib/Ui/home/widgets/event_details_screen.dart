import 'package:evently_app/Ui/home/widgets/info_tile.dart';
import 'package:evently_app/core/firestor_handler.dart';
import 'package:evently_app/core/resoources/assets_manager.dart';
import 'package:evently_app/core/resoources/color_manager.dart';
import 'package:evently_app/model/event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EventDetailsScreen extends StatefulWidget {
  final Event event;

  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  bool isEditing = false;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _latitudeController;
  late TextEditingController _longitudeController;
  late String _type;
  late DateTime _date;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.event.title);
    _descriptionController = TextEditingController(
      text: widget.event.description,
    );
    _latitudeController = TextEditingController(
      text: widget.event.latitude?.toString(),
    );
    _longitudeController = TextEditingController(
      text: widget.event.longitude?.toString(),
    );
    _type = widget.event.type ?? 'birthday';
    _date = widget.event.date?.toDate() ?? DateTime.now();
  }

  void _toggleEdit() {
    setState(() {
      isEditing = !isEditing;
    });
  }

  void _saveChanges() async {
    widget.event.title = _titleController.text;
    widget.event.description = _descriptionController.text;
    widget.event.latitude = double.tryParse(_latitudeController.text) ?? 0.0;
    widget.event.longitude = double.tryParse(_longitudeController.text) ?? 0.0;
    widget.event.type = _type;
    widget.event.date = Timestamp.fromDate(_date);

    await FirestorHandler.updateEvent(widget.event);

    setState(() {
      isEditing = false;
    });
  }

  Future<void> _deleteEvent() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder:
          (_) => AlertDialog(
            title: const Text('Delete Event'),
            content: const Text('Are you sure you want to delete this event?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete'),
              ),
            ],
          ),
    );

    if (confirm == true) {
      await FirestorHandler.deleteEvent(widget.event.id!);
      Navigator.pop(context);
    }
  }

  Future<void> _pickDateTime() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_date),
      );

      if (pickedTime != null) {
        setState(() {
          _date = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );
        });
      }
    }
  }

  String _checkEventImage(String? type) {
    switch (type) {
      case 'sport':
        return AssetsManager.sport;
      case 'book':
        return AssetsManager.bookclub;
      default:
        return AssetsManager.birthday;
    }
  }

  BoxDecoration _fieldDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      border: Border.all(color: ColorManager.blue, width: 1),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Event' : 'Event Details'),
        centerTitle: true,
        actions: [
          if (!isEditing)
            IconButton(icon: const Icon(Icons.edit), onPressed: _toggleEdit),
          if (isEditing)
            IconButton(icon: const Icon(Icons.save), onPressed: _saveChanges),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: _deleteEvent,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                _checkEventImage(_type),
                width: double.infinity,
                height: 200.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 16.h),
            isEditing
                ? TextField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Event Title',
                    border: OutlineInputBorder(),
                  ),
                )
                : Text(
                  _titleController.text,
                  style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
            SizedBox(height: 16.h),
            InfoTile(
              icon: Icons.calendar_today,
              title: DateFormat('dd MMM yyyy').format(_date),
              subtitle: DateFormat('hh:mm a').format(_date),
              onTap: isEditing ? _pickDateTime : null,
            ),
            SizedBox(height: 12.h),
            InfoTile(
              icon: Icons.location_on,
              title: 'Event Location',
              subtitle:
                  'Lat: ${_latitudeController.text}, Lng: ${_longitudeController.text}',
            ),
            SizedBox(height: 16.h),
            Container(
              decoration: _fieldDecoration(),
              padding: EdgeInsets.all(8.w),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: SizedBox(
                  height: 200.h,
                  width: double.infinity,
                  child: GoogleMap(
                    initialCameraPosition: CameraPosition(
                      target: LatLng(
                        double.tryParse(_latitudeController.text) ?? 0.0,
                        double.tryParse(_longitudeController.text) ?? 0.0,
                      ),
                      zoom: 14,
                    ),
                    markers: {
                      Marker(
                        markerId: const MarkerId('event_marker'),
                        position: LatLng(
                          double.tryParse(_latitudeController.text) ?? 0.0,
                          double.tryParse(_longitudeController.text) ?? 0.0,
                        ),
                        infoWindow: InfoWindow(title: _titleController.text),
                      ),
                    },
                    zoomControlsEnabled: false,
                    myLocationButtonEnabled: false,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              'Description',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 8.h),
            Container(
              decoration: _fieldDecoration(),
              padding: EdgeInsets.all(12.w),
              child:
                  isEditing
                      ? TextField(
                        controller: _descriptionController,
                        maxLines: 5,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          isDense: true,
                        ),
                      )
                      : Text(
                        _descriptionController.text,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Theme.of(context).colorScheme.onSurface,
                        ),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}
