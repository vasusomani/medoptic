import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medoptic/model/template_model.dart';
import 'package:medoptic/services/api_services/template_api.dart';
import 'package:medoptic/services/state_management_services/templates_riverpod.dart';
import 'package:medoptic/view/components/qr_modal_sheet.dart';
import '../../../Constants/colors.dart';

class SavedScreen extends ConsumerStatefulWidget {
  const SavedScreen({super.key});

  @override
  ConsumerState<SavedScreen> createState() => _SavedScreenState();
}

class _SavedScreenState extends ConsumerState<SavedScreen> {
  Completer<void> modalCompleter = Completer<void>();
  List<Template> templates = [];

  @override
  void initState() {
    templates = ref.read(templatesProvider);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: CustomColors.primaryColor,
        automaticallyImplyLeading: false,
        title: Text(
          'Saved Prescriptions',
          style: Theme.of(context)
              .textTheme
              .headlineMedium
              ?.copyWith(color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.add, color: Colors.white),
            onPressed: () async {
              await openQrModalSheet(context, modalCompleter, ref,
                      isTemplate: true)
                  .then((value) => setState(() {
                        templates = ref.read(templatesProvider);
                      }));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: templates.length,
        padding: const EdgeInsets.only(top: 5),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              border: Border.all(color: CustomColors.contrastColor1),
              borderRadius: BorderRadius.circular(10),
            ),
            margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 10),
              title: Text(
                "${templates[index].medicineName ?? ''} ${templates[index].medicineDose ?? ""}",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              subtitle: Text(
                "${templates[index].medicineFrequency ?? ''} ${templates[index].medicineQuantityMorning ?? 0}${templates[index].medicineQuantityAfternoon ?? 0}${templates[index].medicineQuantityEvening ?? 0} ",
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit,
                        color: CustomColors.contrastColor1),
                    onPressed: () async {
                      await openQrModalSheet(context, modalCompleter, ref,
                              isTemplate: true, template: templates[index])
                          .then((value) => setState(() {
                                templates = ref.read(templatesProvider);
                              }));
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete,
                        color: CustomColors.contrastColor1),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            title: Text(
                              'Delete Prescription',
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            content: const Text(
                                'Are you sure you want to delete this prescription? You cannot undo this action.'),
                            actions: [
                              TextButton(
                                child: Text(
                                  'Cancel',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: CustomColors.contrastColor1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              TextButton(
                                child: Text(
                                  'Delete',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                        color: CustomColors.contrastColor1,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                onPressed: () async {
                                  // await TemplateApi.
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
