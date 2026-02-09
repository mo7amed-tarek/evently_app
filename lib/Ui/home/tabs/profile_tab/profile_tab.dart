import 'dart:io';
import 'package:evently_app/Ui/login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';

import 'package:evently_app/core/prefs_manager.dart';
import 'package:evently_app/core/resoources/strings_manager.dart';
import 'package:evently_app/providers/theme_provider.dart';
import 'package:evently_app/providers/user_provider.dart';

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
      imageQuality: 80,
    );
    if (picked != null) {
      context.read<UserProvider>().setProfileImage(picked.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final userProv = context.watch<UserProvider>();
    final themeProv = context.watch<themeprovider>();
    final cs = Theme.of(context).colorScheme;

    final avatar =
        userProv.profileImagePath != null
            ? ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.file(
                File(userProv.profileImagePath!),
                width: 80,
                height: 80,
                fit: BoxFit.cover,
              ),
            )
            : CircleAvatar(
              radius: 40,
              backgroundColor: cs.surfaceVariant,
              child: Icon(Icons.person, size: 40, color: cs.primary),
            );

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
              items: const [
                DropdownMenuItem(value: 'ar', child: Text('العربية')),
                DropdownMenuItem(value: 'en', child: Text('English')),
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
              items: const [
                DropdownMenuItem(value: ThemeMode.light, child: Text('Light')),
                DropdownMenuItem(value: ThemeMode.dark, child: Text('Dark')),
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
                backgroundColor: Colors.red,
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

  Padding _title(String txt) => Padding(
    padding: const EdgeInsets.symmetric(horizontal: 16.0),
    child: Text(
      txt,
      style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
    ),
  );

  InputDecoration _decoration(ColorScheme cs) => InputDecoration(
    filled: true,
    fillColor: cs.surface,
    contentPadding: const EdgeInsets.fromLTRB(12, 18, 40, 18),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: cs.primary),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: cs.primary),
    ),
  );
}
