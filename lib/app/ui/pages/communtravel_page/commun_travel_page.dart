// import 'dart:html';

import 'package:calendar_date_picker2/calendar_date_picker2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../controllers/communtravel_controller.dart';

class CommuntravelPage extends GetView<CommuntravelController> {
  final CommuntravelController communtravelController =
      CommuntravelController.to;
  // final String titleAppBar;
  // final Color colorAppBar;
  final String labelMadoalidadTypeB;
  final Color colorBottomCalc;
  final Color colorTitleAndIconCalc;

  CommuntravelPage(
      {super.key,
      // required this.titleAppBar,
      // required this.colorAppBar,
      required this.labelMadoalidadTypeB,
      required this.colorBottomCalc,
      required this.colorTitleAndIconCalc});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            'Período',
            style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
          _buildRangeDatePickerWithValue(communtravelController),
          const SizedBox(height: 30.0),
          Column(
            children: [
              optionModalidad(communtravelController),
              const SizedBox(height: 15.0),
              bottomCalcular(communtravelController),
            ],
          ),
          const SizedBox(height: 30.0),
          infoDateToCashTravel(communtravelController),
          const SizedBox(height: 20.0),
          const Divider(height: 3.0),
          _byNumberPeople(communtravelController)
        ],
      ),
    );
  }

  Widget infoDateToCashTravel(CommuntravelController _) {
    return Obx(() => Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 20.0),
              const Text('Día', style: TextStyle(fontSize: 20.0)),
              const SizedBox(width: 10.0),
              infoDate(_.infoDate.value),
              const SizedBox(width: 20.0),
              const Text('Importe', style: TextStyle(fontSize: 20.0)),
              const SizedBox(width: 10.0),
              infoDate(_.infoImporte.value),
            ],
          ),
        ));
  }

  Widget infoDate(String info) {
    return Container(
      width: 100.0,
      height: 35.0,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5.0),
          border: Border.all(color: Colors.redAccent)),
      child: Center(
          child: Text(
        info,
        style: const TextStyle(fontSize: 20.0),
      )),
    );
  }

  Widget optionModalidad(CommuntravelController _) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'Modalidad',
          style: TextStyle(fontSize: 18.0),
        ),
        const SizedBox(width: 20.0),
        radioOptionA(_, 'A'),
        radioOptionB(_, labelMadoalidadTypeB),
      ],
    );
  }

  Widget radioOptionA(CommuntravelController _, String label) {
    return Obx(() => RadioMenuButton<bool>(
          value: true, //_.stateRadioA.value,
          groupValue: _.stateRadioA.value,
          onChanged: (value) => {
            _.stateRadioA.value = value!,
            _.stateRadioB.value = value ? false : true,
            _.stateRadioC.value = value ? false : true
          },
          child: Text(
            label,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ));
  }

  Widget radioOptionB(CommuntravelController _, String label) {
    return Obx(() => RadioMenuButton<bool>(
          value: true,
          groupValue: label == 'B' ? _.stateRadioB.value : _.stateRadioC.value,
          onChanged: (value) => _.changeStatusRadioBottom(label, value!),
          child: Text(
            label,
            style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
          ),
        ));
  }

  Widget bottomCalcular(CommuntravelController _) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        border: Border.all(color: Colors.pinkAccent, width: 2.0)
      ),
      child: IconButton(
          onPressed: () =>
              communtravelController.calcularPrecio(labelMadoalidadTypeB),
          icon: const Icon(Icons.calculate_outlined,
              color: Colors.pinkAccent, size: 35.0),
              
              ),
    );

    /* TextButton.icon(
      onPressed: () =>
          communtravelController.calcularPrecio(labelMadoalidadTypeB),
      icon: Icon(Icons.calculate,
          color: colorTitleAndIconCalc,
          size: 30.0), //Color.fromARGB(255, 236, 248, 2)
      label: Text('Calcular',
          style: TextStyle(
              color: colorTitleAndIconCalc,
              fontSize: 20.0)), //Color.fromARGB(255, 236, 248, 2)
      style: ButtonStyle(
          backgroundColor: MaterialStateColor.resolveWith((states) =>
              colorBottomCalc)), //const Color.fromARGB(255, 210, 51, 3)
    ); */
  }

  Widget _byNumberPeople(CommuntravelController _) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: SizedBox(
        width: Get.width * 0.8,
        height: Get.height * 0.1,
        child: Row(
          children: [
            Column(
              children: [
                const Text(
                  'Cantidad Personas',
                  style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                ),
                Obx(() => DropdownButton<String>(
                      items: List.generate(
                        20,
                        (index) => DropdownMenuItem(
                          value: '${index + 1}',
                          child: Text('${index + 1}',
                              style: const TextStyle(fontSize: 23.0)),
                        ),
                      ),
                      value: _.valueStatusPersonMore.value,
                      onChanged: (value) {
                        _.valueStatusPersonMore.value = value!;
                        _.calcSumAll();
                      },
                    )),
              ],
            ),
            const SizedBox(width: 20.0),
            Column(
              children: [
                const Text('Importe Total',
                    style:
                        TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
                Obx(() => Text(_.infoImporteTotal.value,
                    style: const TextStyle(fontSize: 23.0)))
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildRangeDatePickerWithValue(CommuntravelController _) {
    final config = CalendarDatePicker2Config(
      centerAlignModePicker: true,
      calendarType: CalendarDatePicker2Type.range,
      selectedDayHighlightColor: Colors.teal[800],
      weekdayLabelTextStyle: const TextStyle(
        color: Colors.black87,
        fontWeight: FontWeight.bold,
      ),
      controlsTextStyle: const TextStyle(
        color: Colors.black,
        fontSize: 15,
        fontWeight: FontWeight.bold,
      ),
      dynamicCalendarRows: true,
      // modePickerBuilder: ({required monthDate, isMonthPicker}) {
      //   return Center(
      //     child: Container(
      //       padding: const EdgeInsets.all(5),
      //       margin: const EdgeInsets.symmetric(horizontal: 5),
      //       decoration: BoxDecoration(
      //         color: isMonthPicker == true ? Colors.red : Colors.teal[800],
      //         borderRadius: BorderRadius.circular(5),
      //       ),
      //       child: Text(
      //         isMonthPicker == true
      //             ? getLocaleShortMonthFormat(const Locale('es'))
      //                 .format(monthDate)
      //             : monthDate.year.toString(),
      //         style: const TextStyle(
      //           color: Colors.white,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     ),
      //   );
      // },
      dayMaxWidth: 33.0,
      // weekdayLabelBuilder: ({required weekday, isScrollViewTopHeader}) {
      //   if (weekday == DateTime.wednesday) {
      //     return const Center(
      //       child: Text(
      //         'W',
      //         style: TextStyle(
      //           color: Colors.red,
      //           fontWeight: FontWeight.bold,
      //         ),
      //       ),
      //     );
      //   }
      //   return null;
      // },

      disabledDayTextStyle:
          const TextStyle(color: Colors.grey, fontWeight: FontWeight.w400),
    );
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 10),
          const Text('Seleccione el rango de tiempo'),
          Obx(() => CalendarDatePicker2(
              config: config,
              value: _.rangeDatePickerValueWithDefaultValue,
              onValueChanged: (dates) {
                // _.rangeDatePickerValueWithDefaultValue.value = dates;
                _.getValueText(config.calendarType, dates);
                _.startDateTime.value = dates.first;
                _.endDateTime.value = dates.last;
              })),
          const SizedBox(height: 10),
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Rango:  ',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Obx(() => Text(_.valueText.value))
            ],
          ),
          const SizedBox(height: 25),
        ],
      ),
    );
  }
}
