import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seguros_viajes/app/controllers/communtravel_controller.dart';
import 'package:seguros_viajes/app/routes/app_routes.dart';
import '../../../controllers/home_controller.dart';

class OptionConfigurationPage extends GetView {
  final CommuntravelController travelController = CommuntravelController.to;
  final HomeController homeController = HomeController.to;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            homeController.visibilityBottomCuba.value = true;
            homeController.visibilityBottomWorld.value = true;
            Get.offAndToNamed(Routes.home);
          },
        ),
        title: const Text(
          'Configuración',
          style: TextStyle(fontSize: 30.0, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 68, 9, 162),
      ),
      body: Obx(() => Column(
            // mainAxisAlignment: MainAxisAlignment.start,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    typeOne('-A- Hacia Cuba: '),
                    typeTwo('${travelController.opcionToCubaA.value} \$'),
                    textFieldFormData('AC')
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    typeOne('-B- Hacia Cuba: '),
                    typeTwo('${travelController.opcionToCubaB.value} \$'),
                    textFieldFormData('BC')
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    typeOne('-A- Al Exterior: '),
                    typeTwo('${travelController.opcionToWorldA.value} \$'),
                    textFieldFormData('AE')
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    typeOne('-C- Al Exterior: '),
                    typeTwo('${travelController.opcionToWorldC.value} \$'),
                    textFieldFormData('CE')
                  ],
                ),
              ),
            ],
          )),
    );
  }

  Widget typeTwo(String label) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0),
      child: Text(
        label,
        style: styleLabelValue(),
      ),
    );
  }

  Widget typeOne(String label) {
    return Text(
      label,
      style: styleLabelOption(),
    );
  }

  Widget textFieldFormData(String tipo) {
    return Padding(
      padding: const EdgeInsets.only(left: 15.0),
      child: SizedBox(
          width: 80.0,
          height: 35.0,
          child: TextFormField(
            decoration: const InputDecoration(
              border: UnderlineInputBorder(borderSide: BorderSide(width: 3.0)),
            ),
            textAlign: TextAlign.center,
            keyboardType: TextInputType.number,
            onChanged: (value) => travelController.cambiarValores(tipo, value),
            style: const TextStyle(fontSize: 20.0),
          )),
    );
  }

  TextStyle styleLabelValue() => const TextStyle(
        fontSize: 20.0,
      );

  TextStyle styleLabelOption() =>
      const TextStyle(fontSize: 23.0, fontWeight: FontWeight.bold);
}
