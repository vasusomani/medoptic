class Template {
  String? templateId;
  String? templateName;
  String? medicineName;
  String? medicineDose;
  String? medicineFrequency;
  String? medicineQuantityMorning;
  String? medicineQuantityAfternoon;
  String? medicineQuantityEvening;
  bool? isBeforeMeal;
  String? doctorName;
  String? expiryDate;
  String? notes;

  Template({
    this.templateId,
    this.templateName,
    this.medicineName,
    this.medicineDose,
    this.medicineFrequency,
    this.medicineQuantityMorning,
    this.medicineQuantityAfternoon,
    this.medicineQuantityEvening,
    this.isBeforeMeal,
    this.doctorName,
    this.expiryDate,
    this.notes,
  });

  Template.fromJson(Map<String, dynamic> json) {
    templateId = json['_id'];
    templateName = json['templateName'];
    medicineName = json['medicineName'];
    medicineDose = json['medicineDose'];
    medicineFrequency = json['medicineFrequency'];
    medicineQuantityMorning = json['medicineQuantity']['morning']['count'] == ""
        ? "0"
        : json['medicineQuantity']['morning']['count'].toString();
    medicineQuantityAfternoon =
        json['medicineQuantity']['afternoon']['count'] == ""
            ? "0"
            : json['medicineQuantity']['afternoon']['count'].toString();
    medicineQuantityEvening = json['medicineQuantity']['evening']['count'] == ""
        ? "0"
        : json['medicineQuantity']['evening']['count'].toString();
    isBeforeMeal = json['medicineQuantity']['morning']['beforeMeal'];
    doctorName = json['doctorName'];
    expiryDate = json['expiryDate'];
    notes = json['notes'];
  }

  Map<String, dynamic> toJson() {
    return {
      'doctorName': doctorName,
      'medicineName': medicineName,
      'medicineDose': medicineDose,
      'medicineFrequency': medicineFrequency,
      'medicineQuantity': {
        'morning': {
          'beforeMeal': isBeforeMeal,
          'count': medicineQuantityMorning
        },
        'afternoon': {
          'beforeMeal': isBeforeMeal,
          'count': medicineQuantityAfternoon
        },
        'evening': {
          'beforeMeal': isBeforeMeal,
          'count': medicineQuantityEvening
        }
      },
      'expiryDate': expiryDate,
      'notes': notes,
      'templateName': templateName,
    };
  }
}
