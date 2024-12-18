class MedTag {
  String? medTagId;
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
  bool? saveAsTemplate;
  String? templateName;

  MedTag({
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
    this.saveAsTemplate,
    this.templateName,
  });

  MedTag.fromJson(Map<String, dynamic> json) {
    medTagId = json['medTagId'];
    medicineName = json['medicineName'];
    medicineDose = json['medicineDose'];
    medicineFrequency = json['medicineFrequency'];
    medicineQuantityMorning = json['medicineQuantityMorning'];
    medicineQuantityAfternoon = json['medicineQuantityAfternoon'];
    medicineQuantityEvening = json['medicineQuantityEvening'];
    isBeforeMeal = json['mealTime'];
    doctorName = json['doctorName'];
    expiryDate = json['expiryDate'];
    notes = json['notes'];
    // saveAsTemplate = json['saveAsTemplate'];
    // templateName = json['templateName'];
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
      'saveAsTemplate': saveAsTemplate,
      'templateName': templateName,
    };
  }
}
