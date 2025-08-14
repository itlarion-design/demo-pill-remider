import 'package:flutter/material.dart';
import 'package:pills_reminder/core/styles/sizes.dart';
import 'package:pills_reminder/features/medications/presentation/screens/edit_medication_screen/edit_medication_screen.dart';

class Fab extends StatelessWidget {
  final ColorScheme theme;
  const Fab({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: AppSizes.buttonSize,
      height: AppSizes.buttonSize,
      child: FloatingActionButton(
        elevation: 0,
        backgroundColor: theme.surfaceContainerLowest,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(AppSizes.roundedRadius),
          ),
          side: BorderSide(
            color: theme.primaryFixedDim,
            width: AppSizes.borderWidth,
          ),
        ),
        onPressed: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => const EditMedicationScreen(),
        ),
        child: const Icon(Icons.medication, size: AppSizes.largeIconSize),
      ),
    );
  }
}
