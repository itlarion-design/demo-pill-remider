import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pills_reminder/core/styles/sizes.dart';
import 'package:pills_reminder/core/styles/styles.dart';
import 'package:pills_reminder/core/widgets/custom_appbar.dart';
import 'package:pills_reminder/features/medications/data/models/medication_model.dart';
import 'package:pills_reminder/features/medications/presentation/controllers/medications_controller.dart';
import 'package:pills_reminder/core/widgets/custom_button.dart';
import 'package:pills_reminder/features/medications/presentation/screens/edit_medication_screen/edit_medication_screen.dart';
import 'package:pills_reminder/features/medications/presentation/screens/medication_screen/widgets/frequency_and_days.dart';
import 'package:pills_reminder/core/widgets/reset_notifications.dart';
import 'package:pills_reminder/features/medications/presentation/screens/medication_screen/widgets/times_item.dart';

class MedicationScreen extends StatefulWidget {
  const MedicationScreen({super.key, required this.medication});
  final MedicationModel medication;

  @override
  State<MedicationScreen> createState() => _MedicationScreenState();
}

class _MedicationScreenState extends State<MedicationScreen> {
  @override
  Widget build(BuildContext context) {
    final controller = Get.find<MedicationController>();
    final theme = Theme.of(context).colorScheme;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(AppSizes.normalPadding),
        child: SingleChildScrollView(
          child: Column(
            spacing: AppSizes.tinyPadding,
            children: [
              CustomAppbar(
                action: CustomButton(
                  onTap: () {
                    /// Edit medication screen
                    showModalBottomSheet(
                      isScrollControlled: true,
                      context: context,
                      builder: (context) =>
                          EditMedicationScreen(medication: widget.medication),
                    );
                  },
                  icon: Icon(Icons.edit, color: theme.onPrimaryContainer),
                ),
              ),

              /// Medication name
              Text(
                widget.medication.name,
                style: AppStyles.title.copyWith(
                  fontSize: AppSizes.extraLargeTextSize,
                ),
              ),

              /// Medication amount
              if (widget.medication.amount != null)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  spacing: AppSizes.largePadding,
                  children: [
                    CustomButton(
                      size: 40,
                      icon: Icon(
                        Icons.remove,
                        size: AppSizes.normalIconSize,
                        color: theme.onPrimaryContainer,
                      ),
                      onTap: () {
                        widget.medication.amount =
                            widget.medication.amount! - 1;
                        controller.updateMedication(widget.medication);
                        setState(() {});
                      },
                    ),
                    Text(
                      "${'remaining'.tr} ${widget.medication.amount}",
                      style: AppStyles.subTitle.copyWith(
                        color: theme.onPrimaryContainer,
                      ),
                    ),
                    CustomButton(
                      size: 40,
                      icon: Icon(
                        Icons.add,
                        size: AppSizes.normalIconSize,
                        color: theme.onPrimaryContainer,
                      ),
                      onTap: () {
                        widget.medication.amount =
                            widget.medication.amount! + 1;
                        controller.updateMedication(widget.medication);
                        setState(() {});
                      },
                    ),
                  ],
                ),

              /// Frequency and days
              FrequencyAndDays(medication: widget.medication),

              SizedBox(height: AppSizes.normalPadding),

              /// Times pills are taken
              ...List.generate(
                widget.medication.times.length,
                (i) => TimesItem(
                  index: i,
                  medication: widget.medication,
                  onChanged: (_) {
                    if (widget.medication.timesPillTaken[i]) {
                      widget.medication.timesPillTaken[i] = false;
                      if (widget.medication.amount != null) {
                        widget.medication.amount =
                            widget.medication.amount! + 1;
                      }
                      controller.updateMedication(widget.medication);
                    } else {
                      widget.medication.timesPillTaken[i] = true;
                      if (widget.medication.amount != null) {
                        widget.medication.amount =
                            widget.medication.amount! - 1;
                      }
                      controller.updateMedication(widget.medication);
                    }
                    setState(() {});
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.normalPadding,
                ),
                child: ResetNotifications(id: widget.medication.id),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
