import 'package:flutter/material.dart';
import 'package:pills_reminder/core/styles/sizes.dart';
import 'package:pills_reminder/features/medications/domain/entities/medication.dart';
import 'package:pills_reminder/features/medications/presentation/screens/main_screen/widgets/medication_widget.dart';

class MedicationList extends StatelessWidget {
  final List<Medication> medicationList;
  const MedicationList({super.key, required this.medicationList});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.largePadding,
        vertical: AppSizes.tinyPadding,
      ),
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(height: 10),
        itemCount: medicationList.length,
        itemBuilder: (context, index) =>
            MedicationWidget(medication: medicationList[index]),
      ),
    );
  }
}
