import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:medoptic/model/template_model.dart';

class TemplateNotifier extends StateNotifier<List<Template>> {
  TemplateNotifier() : super([]);

  addTemplate(Template template) {
    state.add(template);
  }

  setTemplates(List<Template> templates) {
    state = templates;
  }

  updateTemplate(Template template) {
    state = [
      for (final item in state)
        if (item.templateId == template.templateId) template else item
    ];
  }

  emptyTemplates() {
    state = [];
  }
}

final templatesProvider =
    StateNotifierProvider<TemplateNotifier, List<Template>>(
        (ref) => TemplateNotifier());
