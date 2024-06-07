import 'dart:async';

import 'package:flutter/material.dart';
import '../../Constants/colors.dart';
import '../../services/helper_functions/toast_util.dart';
import 'textfields.dart';
import 'buttons.dart';

Future<void> openQrModalSheet(
    BuildContext context, Completer<void> completer) async {
  final FocusNode medicineNameFocus = FocusNode();
  final FocusNode medicineDoseFocus = FocusNode();
  final FocusNode medicineFrequencyFocus = FocusNode();
  final FocusNode doctorNameFocus = FocusNode();
  final FocusNode notesFocus = FocusNode();

  TextEditingController medicineNameController = TextEditingController();
  TextEditingController medicineDoseController = TextEditingController();
  TextEditingController medicineFrequencyController = TextEditingController();
  TextEditingController medicineQuantityMorningController =
      TextEditingController();
  TextEditingController medicineQuantityAfternoonController =
      TextEditingController();
  TextEditingController medicineQuantityEveningController =
      TextEditingController();
  TextEditingController isBeforeMeal = TextEditingController(text: "false");
  TextEditingController isAfterMeal = TextEditingController(text: "false");
  TextEditingController saveTemplate = TextEditingController(text: "false");
  TextEditingController doctorNameController = TextEditingController();
  TextEditingController expiryDateController = TextEditingController();
  TextEditingController notesController = TextEditingController();
  TextEditingController templateNameController = TextEditingController();
  ScrollController scrollController = ScrollController();

  showModalBottomSheet<void>(
    isScrollControlled: true,
    constraints: BoxConstraints(
      maxHeight: MediaQuery.of(context).size.height - kToolbarHeight,
    ),
    transitionAnimationController: AnimationController(
      vsync: Navigator.of(context),
      duration: const Duration(milliseconds: 300),
      reverseDuration: const Duration(milliseconds: 200),
    )..forward(),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
    ),
    isDismissible: false,
    context: context,
    builder: (context) {
      return Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: SingleChildScrollView(
          controller: scrollController,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Add Prescription",
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                          color: CustomColors.contrastColor1,
                        ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: const Icon(Icons.close,
                        color: CustomColors.contrastColor1),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              PrescriptionTextField(
                controller: medicineNameController,
                focusNode: medicineNameFocus,
                hint: "Enter medicine name",
                title: "Medicine Name",
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              PrescriptionTextField(
                controller: medicineDoseController,
                focusNode: medicineDoseFocus,
                hint: "Enter medicine dose (eg: 500mg)",
                title: "Dose",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              PrescriptionTextField(
                controller: medicineFrequencyController,
                focusNode: medicineFrequencyFocus,
                hint: "Enter medicine frequency (eg: Daily, Weekly, etc)",
                title: "Frequency",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              Text("Quantity",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: CustomColors.fontColor1,
                        fontWeight: FontWeight.w600,
                      )),
              const SizedBox(height: 5),
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InputQuantityField(
                      title: "Morning",
                      controller: medicineQuantityMorningController,
                    ),
                    const SizedBox(height: 10),
                    InputQuantityField(
                      title: "Afternoon",
                      controller: medicineQuantityAfternoonController,
                    ),
                    const SizedBox(height: 10),
                    InputQuantityField(
                      title: "Evening",
                      controller: medicineQuantityEveningController,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CheckBoxField(title: "Before Meal", controller: isBeforeMeal),
                  CheckBoxField(title: "After Meal", controller: isAfterMeal),
                ],
              ),
              const SizedBox(height: 20),
              PrescriptionTextField(
                controller: doctorNameController,
                focusNode: doctorNameFocus,
                hint: "Enter doctor name",
                title: "Doctor Name",
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              DateField(
                controller: expiryDateController,
                title: "Expiry Date",
              ),
              const SizedBox(height: 20),
              PrescriptionTextField(
                controller: notesController,
                focusNode: notesFocus,
                hint: "Enter any additional note (optional)",
                title: "Additional Note",
                keyboardType: TextInputType.text,
              ),
              const SizedBox(height: 20),
              SwitchController(
                  controller: saveTemplate, title: "Save as Template"),
              const SizedBox(height: 50),
              Center(
                child: PrimaryButton(
                  onPressed: () {
                    (saveTemplate.text == "true")
                        ? savePrescription(context, templateNameController)
                        : Navigator.of(context).pop();
                    ToastWidget.bottomToast(
                        "Prescription uploaded successfully");
                  },
                  text: "Upload Prescription",
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).viewInsets.bottom,
              ),
            ],
          ),
        ),
      );
    },
  ).then((value) {
    completer.complete();
  });
  // Scroll to focused text field
  double calculateFieldOffset(FocusNode focusNode) {
    final RenderBox renderBox =
        focusNode.context!.findRenderObject() as RenderBox;
    final offset = renderBox.localToGlobal(Offset.zero);
    return offset.dy - MediaQuery.of(context).padding.top;
  }

// Modify the _focusNodeListener to animate to the focused text field
  focusNodeListener() {
    double? offset;
    if (medicineNameFocus.hasFocus) {
      offset = calculateFieldOffset(medicineNameFocus);
    } else if (medicineDoseFocus.hasFocus) {
      offset = calculateFieldOffset(medicineDoseFocus);
    } else if (medicineFrequencyFocus.hasFocus) {
      offset = calculateFieldOffset(medicineFrequencyFocus);
    } else if (doctorNameFocus.hasFocus) {
      offset = calculateFieldOffset(doctorNameFocus);
    } else if (notesFocus.hasFocus) {
      offset = calculateFieldOffset(notesFocus);
    }

    if (offset != null) {
      scrollController.jumpTo(offset);
    }
  }

// Attach the listener to all focus nodes
  medicineNameFocus.addListener(focusNodeListener);
  medicineDoseFocus.addListener(focusNodeListener);
  medicineFrequencyFocus.addListener(focusNodeListener);
  doctorNameFocus.addListener(focusNodeListener);
  notesFocus.addListener(focusNodeListener);
}

void savePrescription(BuildContext context, TextEditingController controller) {
  Navigator.of(context).pop();
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        backgroundColor: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10),
          ),
        ),
        title: Text(
          "Save as Template",
          style: Theme.of(context)
              .textTheme
              .titleMedium
              ?.copyWith(color: CustomColors.fontColor1),
        ),
        content: TextFormField(
          controller: controller,
          cursorColor: CustomColors.contrastColor1,
          decoration: InputDecoration(
            hintText: "Enter template name to save",
            hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.grey.shade700,
                ),
            focusColor: CustomColors.contrastColor1,
            focusedBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: CustomColors.contrastColor1),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text("Cancel",
                style: TextStyle(color: CustomColors.contrastColor2)),
          ),
          TextButton(
            onPressed: () {
              ToastWidget.bottomToast("Prescription saved as template");
              Navigator.of(context).pop();
            },
            child: const Text("Save",
                style: TextStyle(color: CustomColors.contrastColor2)),
          ),
        ],
      );
    },
  );
}
