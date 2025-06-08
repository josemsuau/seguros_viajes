import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seguros_viajes/app/controllers/communtravel_controller.dart';
import 'package:seguros_viajes/app/routes/app_routes.dart';
import 'package:seguros_viajes/app/ui/pages/communtravel_page/commun_travel_page.dart';
import '../../../controllers/home_controller.dart';

class HomePage extends GetView<HomeController> {
  final HomeController homeController = HomeController.to;
  final CommuntravelController communtravelController =
      CommuntravelController.to;

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
      leading: Container(),
        title: const Text(
          'Seguros de Viajes',
          style: TextStyle(fontSize: 30.0, color: Colors.white),
        ),
        backgroundColor: const Color.fromARGB(255, 68, 9, 162),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
            onPressed: () {
              Get.toNamed(Routes.setting);
            },
          )
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Obx(() => Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  rowBottomsOption(),
                  homeController.pageView.value == 1
                      ? CommuntravelPage(
                          labelMadoalidadTypeB: 'B',
                          colorBottomCalc: Colors.pinkAccent,
                          colorTitleAndIconCalc: Colors.white)
                      : homeController.pageView.value == 2
                          ? CommuntravelPage(
                              labelMadoalidadTypeB: 'C',
                              colorBottomCalc: Colors.orangeAccent.shade700,
                              colorTitleAndIconCalc: Colors.white)
                          : homeController.pageView.value == 0
                              ? presentHome(context)//OptionConfigurationPage()
                              : const SizedBox.shrink()
                ],
              )),
        ),
        // child: Expanded(
        //   child: SizedBox(
        //     width: double.infinity,
        //     height: MediaQuery.of(context).size.height,
        //     child: Column(
        //       mainAxisAlignment: MainAxisAlignment.center,
        //       crossAxisAlignment: CrossAxisAlignment.center,
        //       children: [
        //         _commonButtonTravel(
        //             'Viajes hacia Cuba',
        //             Colors.yellowAccent,
        //             const Color.fromARGB(255, 77, 33, 197),
        //             const Icon(
        //               Icons.home,
        //               color: Color.fromARGB(255, 77, 33, 197),
        //             )),
        //         const SizedBox(height: 250.0),
        //         _commonButtonTravel(
        //             'Viajes al Exterior',
        //             Colors.deepOrangeAccent,
        //             const Color.fromARGB(255, 90, 51, 199),
        //             const Icon(Icons.map_rounded,
        //                 color: Color.fromARGB(255, 77, 33, 197))),
        //       ],
        //     ),
        //   ),
        // ),
      ),
    );
  }

  Widget presentHome(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.5,
        child: const Text(
          'Esta es una aplicación para el cálculo de los seguros de viajes. Elija una de las dos opciones que aparecen en la parte superior, "Hacia Cuba" o "Al Exterior"',
          style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25.0,
              overflow: TextOverflow.visible),
        ),
      ),
    );
  }

  Widget viewLogoInHome(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.7,
      child: Image.file(File('assets/logo/logo.jpeg')),
    );
  }

  Widget rowBottomsOption() {
    return Obx(
      () => Row(
        children: [
          _bottomTravelCuba(
              'Hacia Cuba',
              homeController.visibilityBottomCuba.value
                  ? Colors.black26
                  : Colors.white,
              homeController.visibilityBottomCuba.value
                  ? Colors.black26
                  : Colors.deepPurpleAccent,
              Icons.home_work_rounded,
              1,
              homeController),
          const Spacer(),
          _bottomTravelWorld(
              'Al Exterior',
              homeController.visibilityBottomWorld.value
                  ? Colors.black26
                  : Colors.white,
              homeController.visibilityBottomWorld.value
                  ? Colors.black26
                  : const Color.fromARGB(255, 197, 51, 7),
              Icons.south_america_rounded,
              2,
              homeController)
        ],
      ),
    );
  }

  Widget _bottomTravelCuba(String nameOption, Color colorLabelAndIconBottom,
      Color colorBottom, IconData iconsBottom, int type, HomeController _) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton.icon(
        onPressed: () => {
          _.pageView.value = type,
          _.changeVisibilityBottom(type),
          _.clearDataView(communtravelController)
        },
        icon: Icon(
          iconsBottom,
          color: colorLabelAndIconBottom,
        ),
        label: Text(
          nameOption,
          style: TextStyle(color: colorLabelAndIconBottom, fontSize: 20.0),
        ),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => colorBottom)),
      ),
    );
  }

  Widget _bottomTravelWorld(String nameOption, Color colorLabelAndIconBottom,
      Color colorBottom, IconData iconsBottom, int type, HomeController _) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextButton.icon(
        onPressed: () => {
          _.pageView.value = type,
          _.changeVisibilityBottom(type),
          _.clearDataView(communtravelController)
        },
        icon: Icon(
          iconsBottom,
          color: colorLabelAndIconBottom,
        ),
        label: Text(
          nameOption,
          style: TextStyle(color: colorLabelAndIconBottom, fontSize: 20.0),
        ),
        style: ButtonStyle(
            backgroundColor:
                MaterialStateColor.resolveWith((states) => colorBottom)),
      ),
    );
  }

  /* Widget _commonButtonTravel(
      String name, Color colorBoton, Color colorText, Icon iconsBottom) {
    return Container(
      decoration: BoxDecoration(
          color: colorBoton, borderRadius: BorderRadius.circular(8.0)),
      child: TextButton.icon(
        icon: iconsBottom,
        label: Text(
          name,
          style: TextStyle(fontSize: 23.0, color: colorText),
        ),
        onPressed: () => name.contains('Cuba')
            ? Get.toNamed(Routes.travelCuba)
            : Get.toNamed(Routes.travelWorld),
      ),
    );
  } */
}
