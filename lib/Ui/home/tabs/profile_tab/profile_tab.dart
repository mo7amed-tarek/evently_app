import 'dart:convert';
import 'dart:io';
import 'package:evently_app/Ui/login/screen/login_screen.dart';
import 'package:evently_app/core/firestor_handler.dart';
import 'package:evently_app/core/prefs_manager.dart';
import 'package:evently_app/core/resoources/color_manager.dart';
import 'package:evently_app/core/resoources/strings_manager.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

class ProfileTab extends StatefulWidget {
  static const String routeName = '/profile';

  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends State<ProfileTab> {
  late String _currentLangCode;
  late ThemeMode _currentTheme;
  bool _initialized = false;
  final _picker = ImagePicker();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _currentLangCode = context.locale.languageCode;
      _currentTheme = context.read<themeprovider>().themeMode;
      _initialized = true;
    }
  }

  Future<void> _pickImage() async {
    final XFile? picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 400, // Limit resolution
      maxHeight: 400,
      imageQuality: 30, // Significant compression
    );
    if (picked != null) {
      final userProv = context.read<UserProvider>();
      final uid = FirebaseAuth.instance.currentUser?.uid;
      if (uid == null) return;

      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => const Center(child: CircularProgressIndicator()),
      );

      try {
        final bytes = await File(picked.path).readAsBytes();
        final base64Image = base64Encode(bytes);
        
        await FirestorHandler.updateUserProfileImage(uid, base64Image);
        
        if (userProv.myUser != null) {
          userProv.myUser!.profileImage = base64Image;
          userProv.notifyListeners();
        }
        
        userProv.setProfileImage(picked.path);
        Navigator.pop(context);
      } catch (e) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Save failed: $e')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProv = context.watch<UserProvider>();
    final themeProv = context.watch<themeprovider>();
    final cs = Theme.of(context).colorScheme;

    Widget buildAvatar() {
      if (userProv.myUser?.profileImage != null && 
          userProv.myUser!.profileImage!.length > 100) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.memory(
            base64Decode(userProv.myUser!.profileImage!),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _defaultAvatar(cs),
          ),
        );
      }
      
      if (userProv.profileImagePath != null) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: Image.file(
            File(userProv.profileImagePath!),
            width: 80,
            height: 80,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) => _defaultAvatar(cs),
          ),
        );
      }
      
      return _defaultAvatar(cs);
    }

    final avatar = buildAvatar();

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(16, 48, 16, 24),
            decoration: BoxDecoration(
              color: cs.primary,
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(60),
              ),
            ),
            child: Row(
              children: [
                GestureDetector(onTap: _pickImage, child: avatar),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userProv.myUser?.name ?? '',
                        style: Theme.of(
                          context,
                        ).textTheme.titleMedium!.copyWith(color: cs.onPrimary),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        userProv.myUser?.email ?? '',
                        style: Theme.of(context).textTheme.bodySmall!.copyWith(
                          color: cs.onPrimary.withOpacity(.7),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          _title(StringsManager.language.tr()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<String>(
              isExpanded: true,
              value: _currentLangCode,
              items: [
                DropdownMenuItem(value: 'ar', child: Text(StringsManager.arabic.tr())),
                DropdownMenuItem(value: 'en', child: Text(StringsManager.english.tr())),
              ],
              onChanged: (code) async {
                if (code == null) return;
                setState(() => _currentLangCode = code);
                await context.setLocale(Locale(code));
              },
              decoration: _decoration(cs),
            ),
          ),
          _title(StringsManager.theme.tr()),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: DropdownButtonFormField<ThemeMode>(
              isExpanded: true,
              value: _currentTheme,
              items: [
                DropdownMenuItem(value: ThemeMode.light, child: Text(StringsManager.light.tr())),
                DropdownMenuItem(value: ThemeMode.dark, child: Text(StringsManager.dark.tr())),
              ],
              onChanged: (mode) {
                if (mode == null) return;
                setState(() => _currentTheme = mode);
                themeProv.changetheme(mode);
                PrefsManager.savathemeMode(mode == ThemeMode.dark);
              },
              decoration: _decoration(cs),
            ),
          ),

          const SizedBox(height: 32),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton.icon(
              onPressed: () async {
                await FirebaseAuth.instance.signOut();

                context.read<UserProvider>().clearUser();
                if (!mounted) return;

                Navigator.of(
                  context,
                  rootNavigator: true,
                ).pushNamedAndRemoveUntil(LoginScreen.routeName, (_) => false);
              },
              icon: const Icon(Icons.logout),
              label: Text(StringsManager.logout.tr()),
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorManager.red,
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(54),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _defaultAvatar(ColorScheme cs) => CircleAvatar(
        radius: 40,
        backgroundColor: cs.surfaceVariant,
        child: Icon(Icons.person, size: 40, color: cs.primary),
      );

  Padding _title(String txt) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Text(
      txt,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
    ),
  );

  InputDecoration _decoration(ColorScheme cs) => InputDecoration(
    filled: true,
    fillColor: Colors.transparent,
    contentPadding: const EdgeInsets.fromLTRB(12, 18, 40, 18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: cs.primary),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: cs.primary, width: 2),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: cs.primary, width: 2),
    ),
  );
}
