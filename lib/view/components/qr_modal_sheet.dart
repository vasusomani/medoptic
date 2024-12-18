import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medoptic/model/template_model.dart';
import 'package:medoptic/services/api_services/template_api.dart';
import 'package:medoptic/services/state_management_services/templates_riverpod.dart';
import '../../Constants/colors.dart';
import '../../model/medtag_model.dart';
import '../../services/api_services/medTag_api.dart';
import '../../services/helper_functions/time.dart';
import '../../services/helper_functions/toast_util.dart';
import 'textfields.dart';
import 'buttons.dart';

Future<void> openQrModalSheet(
    BuildContext context, Completer<void> completer, WidgetRef ref,
    {String? medTagId, bool isTemplate = false, Template? template}) async {
  ValueNotifier<String> mealTime = ValueNotifier<String>(template != null
      ? template.isBeforeMeal == null
          ? 'before'
          : (template.isBeforeMeal! ? 'before' : 'after')
      : 'before');
  TextEditingController medicineNameController =
      TextEditingController(text: template?.medicineName);
  TextEditingController medicineDoseController =
      TextEditingController(text: template?.medicineDose);
  TextEditingController medicineFrequencyController =
      TextEditingController(text: template?.medicineFrequency);
  TextEditingController medicineQuantityMorningController =
      TextEditingController(text: template?.medicineQuantityMorning);
  TextEditingController medicineQuantityAfternoonController =
      TextEditingController(text: template?.medicineQuantityAfternoon);
  TextEditingController medicineQuantityEveningController =
      TextEditingController(text: template?.medicineQuantityEvening);
  TextEditingController isBeforeMeal =
      TextEditingController(text: template?.isBeforeMeal.toString());
  TextEditingController isAfterMeal =
      TextEditingController(text: template?.isBeforeMeal.toString());
  TextEditingController saveTemplate = TextEditingController(text: "false");
  TextEditingController doctorNameController =
      TextEditingController(text: template?.doctorName);
  TextEditingController expiryDateController =
      TextEditingController(text: template?.expiryDate);
  TextEditingController notesController =
      TextEditingController(text: template?.notes);
  TextEditingController templateNameController =
      TextEditingController(text: template?.templateName);
  ScrollController scrollController = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  savePrescription() async {
    if (formKey.currentState!.validate()) {
      if (saveTemplate.text == "true") {
        await showDialog(
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
                controller: templateNameController,
                cursorColor: CustomColors.contrastColor1,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Please enter a name to save as template";
                  }
                  return null;
                },
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
                // TextButton(
                //   onPressed: () {
                //     Navigator.of(context).pop();
                //   },
                //   child: const Text("Cancel",
                //       style: TextStyle(color: CustomColors.contrastColor2)),
                // ),
                TextButton(
                  onPressed: () {
                    if (templateNameController.text.isNotEmpty) {
                      Navigator.of(context).pop();
                    }
                  },
                  child: const Text("Save",
                      style: TextStyle(color: CustomColors.contrastColor2)),
                ),
              ],
            );
          },
        );
      }
      MedTag medTag = MedTag(
        medicineName: medicineNameController.text,
        medicineDose: medicineDoseController.text,
        medicineFrequency: medicineFrequencyController.text,
        medicineQuantityMorning: medicineQuantityMorningController.text,
        medicineQuantityAfternoon: medicineQuantityAfternoonController.text,
        medicineQuantityEvening: medicineQuantityEveningController.text,
        isBeforeMeal: isBeforeMeal.text == "true",
        doctorName: doctorNameController.text,
        expiryDate: expiryDateController.text,
        notes: notesController.text,
        saveAsTemplate: saveTemplate.text == "true",
        templateName: templateNameController.text,
      );
      TimerService timerService = TimerService();
      timerService.startTimer();
      final Map<String, dynamic>? responseBody =
          await MedTagApi().createMedTag(medTag: medTag, medTagId: medTagId!);
      if (responseBody != null) {
        if (responseBody['type'] == 'success') {
          if (saveTemplate.text == "true") {
            Template template =
                Template.fromJson(responseBody['data']['template']);
            // ref.watch(templateProvider).addTemplate(template);
            debugPrint("template${template.toJson()}");
            ref.watch(templatesProvider).add(template);
          }
          Navigator.of(context).pop();
          timerService.stopTimer();
          ToastWidget.bottomToast("Prescription uploaded successfully");
        }
      }
    }
  }

  saveTemplateFunction() async {
    await showDialog(
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
            controller: templateNameController,
            cursorColor: CustomColors.contrastColor1,
            validator: (value) {
              if (value!.isEmpty) {
                return "Please enter a name to save as template";
              }
              return null;
            },
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
            // TextButton(
            //   onPressed: () {
            //     Navigator.of(context).pop();
            //   },
            //   child: const Text("Cancel",
            //       style: TextStyle(color: CustomColors.contrastColor2)),
            // ),
            TextButton(
              onPressed: () {
                if (templateNameController.text.isNotEmpty) {
                  Navigator.of(context).pop();
                }
              },
              child: const Text("Save",
                  style: TextStyle(color: CustomColors.contrastColor2)),
            ),
          ],
        );
      },
    );

    Template template = Template(
      medicineName: medicineNameController.text,
      medicineDose: medicineDoseController.text,
      medicineFrequency: medicineFrequencyController.text,
      medicineQuantityMorning: medicineQuantityMorningController.text,
      medicineQuantityAfternoon: medicineQuantityAfternoonController.text,
      medicineQuantityEvening: medicineQuantityEveningController.text,
      isBeforeMeal: isBeforeMeal.text == "true",
      doctorName: doctorNameController.text,
      expiryDate: expiryDateController.text,
      notes: notesController.text,
      templateName: templateNameController.text,
    );
    final Map<String, dynamic>? responseBody =
        await TemplateApi().createTemplate(template: template);
    if (responseBody != null) {
      if (responseBody['type'] == 'success') {
        if (saveTemplate.text == "true") {
          Template template =
              Template.fromJson(responseBody['data']['template']);
          ref.watch(templatesProvider).add(template);
          debugPrint("template${template.toJson()}");
        }
        Navigator.of(context).pop();
        ToastWidget.bottomToast("Prescription uploaded successfully");
      }
    }
  }

  editTemplate() async {
    if (formKey.currentState!.validate()) {
      Template templateModel = Template(
        templateId: template!.templateId,
        medicineName: medicineNameController.text,
        medicineDose: medicineDoseController.text,
        medicineFrequency: medicineFrequencyController.text,
        medicineQuantityMorning: medicineQuantityMorningController.text,
        medicineQuantityAfternoon: medicineQuantityAfternoonController.text,
        medicineQuantityEvening: medicineQuantityEveningController.text,
        isBeforeMeal: isBeforeMeal.text == "true",
        doctorName: doctorNameController.text,
        expiryDate: expiryDateController.text,
        notes: notesController.text,
        templateName: templateNameController.text,
      );
      final Map<String, dynamic>? responseBody =
          await TemplateApi().updateTemplate(template: templateModel);
      if (responseBody != null) {
        if (responseBody['type'] == 'success') {
          Template template =
              Template.fromJson(responseBody['data']['template']);
          ref.watch(templatesProvider.notifier).updateTemplate(template);
          debugPrint("template${template.toJson()}");
          Navigator.of(context).pop();
          ToastWidget.bottomToast("Prescription uploaded successfully");
        }
      }
    }
  }

  await showModalBottomSheet<void>(
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
      debugPrint("isTemplate: $isTemplate");

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
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isTemplate ? "Save Template" : "Upload Prescription",
                      style:
                          Theme.of(context).textTheme.headlineMedium?.copyWith(
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
                MedTagTextField(
                  controller: medicineNameController,
                  hint: "Enter medicine name",
                  title: "Medicine Name",
                  keyboardType: TextInputType.name,
                ),
                const SizedBox(height: 20),
                MedTagTextField(
                  controller: medicineDoseController,
                  hint: "Enter medicine dose (eg: 500mg)",
                  title: "Dose",
                  keyboardType: TextInputType.text,
                ),
                const SizedBox(height: 20),
                MedTagTextField(
                  controller: medicineFrequencyController,
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
                    RadioButtonField(
                      title: "Before Meal",
                      controller: isBeforeMeal,
                      value: 'before',
                      groupValue: mealTime,
                      onChanged: (String? newValue) {
                        mealTime.value = newValue ?? 'before';
                        isBeforeMeal.text =
                            (mealTime.value == 'before').toString();
                        isAfterMeal.text =
                            (mealTime.value == 'after').toString();
                      },
                    ),
                    RadioButtonField(
                      title: "After Meal",
                      controller: isAfterMeal,
                      value: 'after',
                      groupValue: mealTime,
                      onChanged: (String? newValue) {
                        mealTime.value = newValue ?? 'before';
                        isBeforeMeal.text =
                            (mealTime.value == 'before').toString();
                        isAfterMeal.text =
                            (mealTime.value == 'after').toString();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                MedTagTextField(
                  controller: doctorNameController,
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
                MedTagTextField(
                  controller: notesController,
                  hint: "Enter any additional note (optional)",
                  title: "Additional Note",
                  isRequired: false,
                  keyboardType: TextInputType.text,
                ),
                if (!isTemplate) const SizedBox(height: 20),
                if (!isTemplate)
                  SwitchController(
                      controller: saveTemplate, title: "Save as Template"),
                const SizedBox(height: 50),
                Center(
                  child: PrimaryButton(
                    onPressed: () async {
                      if (isTemplate) {
                        if (template != null) {
                          await editTemplate();
                        } else {
                          await saveTemplateFunction();
                        }
                      } else {
                        await savePrescription();
                      }
                    },
                    text: isTemplate ? "Save Template" : "Upload Prescription",
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: MediaQuery.of(context).viewInsets.bottom,
                ),
              ],
            ),
          ),
        ),
      );
    },
  ).then((value) {
    completer.complete();
  });
}
