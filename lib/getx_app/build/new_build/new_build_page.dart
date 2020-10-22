import 'package:flutter/material.dart';
import 'package:gesco/getx_app/build/new_build/new_build_controller.dart';
import 'package:gesco/getx_app/home_page/home_page.dart';
import 'package:gesco/ui/app_header.dart';
import 'package:gesco/ui/application_page.dart';
import 'package:gesco/utils/common_validator.dart';
import 'package:get/get.dart';

class NewBuildPage extends StatelessWidget {
  var controller = NewBuildController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(
                height: 20.0,
              ),
              Row(
                children: <Widget>[
                  InkWell(
                    onTap: () {
                      Get.to(ApplicationPage());
                    },
                    child: AppHeader(isMainPage: false),
                  ),
                ],
              ),
              Form(
                key: controller.formKey.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    nameField(),
                    addressField(),
                    zipCodeField(),
                    sizeField(),
                    builderField(),
                    engineerField(),
                    phaseField(),
                    engineerSwitch(controller.isSwitch),
                    buildSizedBox(),
                    buildFlatButton(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildFlatButton() {
    return Obx(() => controller.loading == true
        ? Center(child: Row(
          children: [
            CircularProgressIndicator(),
            Text('Salvando')
          ],
        ))
        : FlatButton(
            color: Colors.blue,
            textColor: Colors.white,
            padding: EdgeInsets.all(10.0),
            splashColor: Colors.blueAccent,
            onPressed: () => controller.saveBuild(),
            child: Text(
              'Salvar',
              style: TextStyle(fontSize: 20.0),
            ),
          ));
  }

  SizedBox buildSizedBox() {
    return SizedBox(
      height: 20,
    );
  }

  Widget engineerSwitch(RxBool isSwitched) {
    return Obx(() {
      return SwitchListTile(
          title: Text('Engenheiro precisa aprovar pedido'),
          value: isSwitched.value,
          onChanged: (value) => controller.isSwitch.value = value);
    });
  }

  Widget engineerField() {
    return Obx(
      () => TextFormField(
        controller: controller.engineerController.value,
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Insira email do engenheiro',
          labelText: 'Engenheiro',
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.next,
        validator: (value) => controller.validateEngineer(value),
      ),
    );
  }

  Widget phaseField() {
    return Obx(() => DropdownButtonFormField<String>(
        value: controller.phaseController.value.text,
        items: controller.items
            .map((e) => DropdownMenuItem(
                  child: Text(e),
                  value: e,
                ))
            .toList(),
        decoration: const InputDecoration(
          icon: Icon(Icons.timeline),
          hintText: 'Insira em que etapa a obra esta',
          labelText: 'Etapa',
        ),
        onChanged: (value) => controller.phaseController.value.text = value,
        validator: (value) => CommonValidator.validateEmptyString(value)
            ? "etapa é necessario"
            : null));
  }

  Widget builderField() {
    return Obx(() => TextFormField(
        controller: controller.builderController.value,
        decoration: const InputDecoration(
          icon: Icon(Icons.person),
          hintText: 'Insira o usuário do mestre de obras ',
          labelText: 'Mestre de obra *',
        ),
        keyboardType: TextInputType.emailAddress,
        validator: (value) => CommonValidator.validateEmail(value)
            ? "informe um email válido"
            : null));
  }

  Widget zipCodeField() {
    return Obx(() => TextFormField(
        controller: controller.zipCodeController.value,
        decoration: const InputDecoration(
          icon: Icon(Icons.location_searching),
          hintText: 'Insira o CEP da obra',
          labelText: 'CEP *',
        ),
        validator: (value) => CommonValidator.validateEmptyString(value)
            ? "informe um cep"
            : null));
  }

  Widget addressField() {
    return Obx(() => TextFormField(
        controller: controller.addressController.value,
        maxLength: 25,
        decoration: const InputDecoration(
          icon: Icon(Icons.add_location),
          hintText: 'Insira o endereço da obra',
          labelText: 'Endereço *',
        ),
        validator: (value) => CommonValidator.validateEmptyString(value)
            ? 'Insira um endereço válido'
            : null));
  }

  Widget nameField() {
    return Obx(() => TextFormField(
        maxLength: 12,
        controller: controller.nameController.value,
        decoration: const InputDecoration(
          icon: Icon(Icons.add_location),
          hintText: 'Insira um nome para obra',
          labelText: 'Nome *',
        ),
        validator: (value) => CommonValidator.validateEmptyString(value)
            ? 'Informe um nome para obra'
            : null));
  }

  TextFormField sizeField() {
    return TextFormField(
      controller: controller.sizeController.value,
      decoration: const InputDecoration(
        icon: Icon(Icons.photo_size_select_small),
        hintText: 'Insira o tamanho da obra',
        labelText: 'Tamanho *',
      ),
      validator: (value) => CommonValidator.validateEmptyString(value)
          ? 'Informe o tamanho da obra'
          : null,
      keyboardType: TextInputType.number,
    );
  }
}
