import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seguros_viajes/app/data/provider/shared_preferences.dart';

class CommuntravelController extends GetxController {
  static CommuntravelController get to => Get.find<CommuntravelController>();
  RxList<DateTime?> rangeDatePickerValueWithDefaultValue = RxList.empty();
  late SharePreferenceService preferenceService;

  RxBool stateRadioA = RxBool(false);
  RxBool stateRadioB = RxBool(false);
  RxBool stateRadioC = RxBool(false);
  RxString valueText = RxString('');
  Duration timeTravel = const Duration();

  RxDouble opcionToCubaA = 60.0.obs;
  RxDouble opcionToCubaB = 72.0.obs;
  RxDouble opcionToWorldA = 72.0.obs;
  RxDouble opcionToWorldC = 84.0.obs;

  RxString valueStatusPersonMore = '1'.obs;

  Rx<DateTime> startDateTime = Rx(DateTime(0));
  Rx<DateTime> endDateTime = Rx(DateTime(0));

  RxString infoDate = RxString('');
  RxString infoImporte = RxString('');
  RxString infoImporteTotal = RxString('');

  RxString startDate = RxString('');
  RxString endDate = RxString('');

  Future<void> conocerPreciosActuales() async {
    preferenceService = await SharePreferenceService.getInstance();
    if (!preferenceService.opcionToCubaA.isEqual(opcionToCubaA.value) &&
        !preferenceService.opcionToCubaA.isEqual(0.0)) {
      opcionToCubaA.value = preferenceService.opcionToCubaA;
    }
    if (!preferenceService.opcionToCubaB.isEqual(opcionToCubaB.value) &&
        !preferenceService.opcionToCubaB.isEqual(0.0)) {
      opcionToCubaB.value = preferenceService.opcionToCubaB;
    }
    if (!preferenceService.opcionToWorldA.isEqual(opcionToWorldA.value) &&
        !preferenceService.opcionToWorldA.isEqual(0.0)) {
      opcionToWorldA.value = preferenceService.opcionToWorldA;
    }
    if (!preferenceService.opcionToWorldC.isEqual(opcionToWorldC.value) &&
        !preferenceService.opcionToWorldC.isEqual(0.0)) {
      opcionToWorldC.value = preferenceService.opcionToWorldC;
    }
  }

  Future<void> cambiarValores(String cambioTipo, String valor) async {
    preferenceService = await SharePreferenceService.getInstance();
    if (valor.isNotEmpty) {
      switch (cambioTipo) {
        case 'AC':
          preferenceService.opcionToCubaA = double.parse(valor);
          break;
        case 'BC':
          preferenceService.opcionToCubaB = double.parse(valor);
          break;
        case 'AE':
          preferenceService.opcionToWorldA = double.parse(valor);
          break;
        case 'CE':
          preferenceService.opcionToWorldC = double.parse(valor);
          break;
      }
    }
    conocerPreciosActuales();
  }

  RxList<DateTime> beginDate() {
    DateTime dateNow = DateTime.now();
    startDateTime.value = DateTime(dateNow.year, dateNow.month, dateNow.day);
    endDateTime.value = DateTime(
        dateNow.month == 12 ? dateNow.year + 1 : dateNow.year,
        dateNow.month == 12 ? 1 : dateNow.month,
        dateNow.day + 7);
    timeTravel = endDateTime.value.difference(startDateTime.value);
    return RxList([startDateTime.value, endDateTime.value]);
  }

  void getValueText(
    CalendarDatePicker2Type datePickerType,
    List<DateTime?> values,
  ) {
    values =
        values.map((e) => e != null ? DateUtils.dateOnly(e) : null).toList();
    valueText.value = (values.isNotEmpty ? values[0] : null)
        .toString()
        .replaceAll('00:00:00.000', '');
    if (datePickerType == CalendarDatePicker2Type.multi) {
      valueText.value = values.isNotEmpty
          ? values
              .map((v) => v.toString().replaceAll('00:00:00.000', ''))
              .join(', ')
          : 'null';
    } else if (datePickerType == CalendarDatePicker2Type.range) {
      if (values.isNotEmpty) {
        startDate.value = values[0].toString().replaceAll('00:00:00.000', '');
        endDate.value = values.length > 1
            ? values[1].toString().replaceAll('00:00:00.000', '')
            : 'null';
        valueText.value = 'Desde ${startDate.value} hasta ${endDate.value}';
      } else {
        // return 'null';
        valueText.value = '-';
      }
    }
    // return valueText.value;
  }

  void calcularPrecio(String labelRadioOption) {//arreglar aqui la cantidad de dias
    double calc = 0.0;
    // timeTravel = endDateTime.value.difference(startDateTime.value);
    final time = endDateTime.value.difference(startDateTime.value).inHours;
    double days = time / 24;
    days = days.round() + 1;
    if (stateRadioA.value || stateRadioB.value || stateRadioC.value) {
      infoDate.value = '${days.floor()}';
      if (stateRadioA.value) {
        if (labelRadioOption == 'B') {
          calc = days * opcionToCubaA.value; //Viajes hacia cuba opcion A = 60
        } else {
          calc = days * opcionToCubaB.value; //Viajes hacia cuba opcion B = 72
        }
      } else if (stateRadioB.value && labelRadioOption == 'B') {
        calc = days * opcionToWorldA.value; //Viajes al exterior opcion A = 72
      } else if (stateRadioC.value && labelRadioOption == 'C') {
        calc = days * opcionToWorldC.value; //Viajes al exterior opcion C = 84
      }
      infoImporte.value = '$calc';
      calcSumAll();
    } else {
      Get.snackbar('Advertencia', 'Tiene que seleccionar alguna modalidad',
          backgroundColor: Colors.transparent);
    }
  }

  void calcSumAll() {
    if (infoImporte.value.isNotEmpty &&
        valueStatusPersonMore.value.isNotEmpty) {
      infoImporteTotal.value = (double.parse(infoImporte.value) *
              double.parse(valueStatusPersonMore.value))
          .toString();
    } else {
      Get.snackbar('Advertencia', 'Es necesario que exista el Importe');
    }
  }

  void changeStatusRadioBottom(String label, bool valueStatus) {
    if (label == 'B') {
      stateRadioB.value = valueStatus;
      stateRadioC.value = false;
    } else {
      stateRadioC.value = valueStatus;
      stateRadioB.value = false;
    }
    stateRadioA.value = valueStatus ? false : true;
  }

  @override
  void onInit() {
    conocerPreciosActuales();
    rangeDatePickerValueWithDefaultValue = beginDate();
    getValueText(
        CalendarDatePicker2Type.range, rangeDatePickerValueWithDefaultValue);
    super.onInit();
  }

  @override
  void onClose() {
    // TODO: implement onClose
    rangeDatePickerValueWithDefaultValue = RxList.empty();
    super.onClose();
  }
}
