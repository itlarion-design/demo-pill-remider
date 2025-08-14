import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/core/styles/sizes.dart';
import 'package:pills_reminder/core/widgets/custom_drop_down.dart';
import 'package:pills_reminder/core/widgets/reset_notifications.dart';
import 'package:pills_reminder/features/settings/presentation/widgets/custom_app_bar.dart';
import 'package:pills_reminder/features/settings/presentation/widgets/custom_theme_dropdown.dart';
import 'package:pills_reminder/features/settings/presentation/controllers/settings_controller.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).colorScheme;
    final themeController = Get.find<SettingsController>();
    return Scaffold(
      backgroundColor: theme.surface,
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.normalPadding),
        child: Column(
          spacing: AppSizes.largePadding,
          children: [
            CustomAppBar(),
            CustomDropDown(
              label: 'appLange'.tr,
              value: themeController.locale.value.languageCode,
              items: ['en', 'ar'],
              onChanged: (locale) =>
                  themeController.changeLocale(locale!.toString()),
              customNames: {'en': 'en'.tr, 'ar': 'ar'.tr},
            ),
            CustomDropDown(
              label: 'themeMode'.tr,
              value: themeController.themeMode.value,
              items: const [ThemeMode.system, ThemeMode.light, ThemeMode.dark],
              onChanged: (mode) => themeController.changeThemeMode(mode!),
              customNames: {
                ThemeMode.system: 'followSystem'.tr,
                ThemeMode.light: 'light'.tr,
                ThemeMode.dark: 'dark'.tr,
              },
            ),
            CustomThemeDropdown(themeController: themeController),
            ResetNotifications(),
          ],
        ),
      ),
    );
  }
}
