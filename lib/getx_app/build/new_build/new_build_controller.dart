import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/src/widgets/form.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:gesco/app/build/build_repository.dart';
import 'package:gesco/getx_app/home/application_page.dart';
import 'package:gesco/getx_app/home/home_controller.dart';
import 'package:gesco/utils/common_validator.dart';
import 'package:get/get.dart';

import '../build_model.dart';

class NewBuildController extends GetxController {
  Rx<GlobalKey<FormState>> formKey = GlobalKey<FormState>().obs;

  RxBool isSwitch = false.obs;
  RxBool loading = false.obs;
  Rx<TextEditingController> engineerController = TextEditingController().obs;
  Rx<TextEditingController> phaseController = TextEditingController().obs;
  Rx<TextEditingController> builderController = TextEditingController().obs;
  Rx<TextEditingController> zipCodeController = TextEditingController().obs;
  Rx<TextEditingController> addressController = TextEditingController().obs;
  Rx<TextEditingController> nameController = TextEditingController().obs;
  Rx<TextEditingController> sizeController = TextEditingController().obs;

  NewBuildController() {phaseController.value.text = items[0];}

  List<String> get items => [
    'Preliminares',
    'Estrutura',
    'Alvenaria',
    'Hidráulica/Elétrica',
    'Complementares',
    'Cobertura',
    'Acabamento'
  ];

  bool formValidate(GlobalKey<FormState> formKey) => true;

  void saveBuild() {
    if (formKey.value.currentState.validate()) {
      Build build = Build();

      build.name = nameController.value.text;
      build.address = addressController.value.text;
      build.zipCode = zipCodeController.value.text;
      build.owner = FirebaseAuth.instance.currentUser.email;
      build.buildSize = double.parse(sizeController.value.text);
      build.builder = builderController.value.text;
      build.engineer = engineerController.value.text;
      build.phase = phaseController.value.text;

      build.progress = double.parse('0.0');
      build.cust = double.parse('0.0');
      build.orderNeedsAproval = isSwitch.value;
      build.ordersNumber = 0;
      build.buildImage =
          'https://www.conjur.com.br/img/b/pedreiro-ajudante-obra.png';

      loading.value = true;

      BuildRepository().add(build).then((value) {
        build.documentId = value;
        HomePageController homePageController = Get.find();
        homePageController.builds.add(build.obs);

        loading.value = false;
        Get.snackbar('Obra adicionada', 'obra ${build.name} salva com sucesso');
        Get.to(ApplicationPage());
      }, onError: (e) => print(e));
    } else {
      Get.snackbar('Campos inválidos', 'verifique os dados informados');
    }
  }

  validateUser(String value, String s) => true;

  validateEngineer(String value) {
    if(CommonValidator.validateEmail(value))
        return 'informe um email válido';
    if(value == builderController.value.text)
      return 'o engenheiro não pode ser igual ao construtor';
    return null;
  }

  validateBuilder(String value) {
    if(CommonValidator.validateEmail(value))
      return 'informe um email válido';
    if(value == engineerController.value.text)
      return 'o construtor não pode ser igual ao engenheiro';
    return null;
  }
}
