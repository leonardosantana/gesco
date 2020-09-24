import 'package:flutter/material.dart';
import 'package:gesco/app/build/new_build/new_build_bloc.dart';
import 'package:gesco/ui/app_header.dart';

class NewBuildPage extends StatefulWidget {
  final String title;
  const NewBuildPage({Key key, this.title = "NewBuild"}) : super(key: key);

  @override
  _NewBuildPageState createState() => _NewBuildPageState();
}

class _NewBuildPageState extends State<NewBuildPage> {
  String _name;
  String _builder;
  String _engineer;
  String _address;
  String _zipCode;
  double _buildSize;
  bool _engineerSwitch;

  NewBuildBloc bloc = new NewBuildBloc();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isSwitched = false;


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
                      Navigator.pop(context);
                    },
                    child: AppHeader(isMainPage: false),
                  ),
                ],
              ),
              Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    nameField(),
                    addressField(),
                    zipCodeField(),
                    sizeField(),
                    builderField(),
                    engineerField(),
                    engineerSwitch(isSwitched),
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

  FlatButton buildFlatButton() {
    return FlatButton(
      color: Colors.blue,
      textColor: Colors.white,
      padding: EdgeInsets.all(10.0),
      splashColor: Colors.blueAccent,
      onPressed: () => saveBuild(),
      child: Text(
        'Salvar',
        style: TextStyle(fontSize: 20.0),
      ),
    );
  }

  saveBuild(){
    if(bloc.formValidate(_formKey)){
      bloc.saveBuild(_name, _address, _buildSize, _zipCode, _builder, _engineer, _engineerSwitch);
    }

  }

  SizedBox buildSizedBox() {
    return SizedBox(
      height: 20,
    );
  }

  SwitchListTile engineerSwitch(bool isSwitched) {
    return SwitchListTile(
      title: Text('Engenheiro precisa aprovar pedido'),
      value: _engineerSwitch,
      onChanged: (value) =>
          setState((){
            if(_formKey.currentState.validate()){
              _formKey.currentState.save();
            }
            _engineerSwitch = value;}),
    );
  }

  TextFormField engineerField() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Insira o usuário do engenheiro',
        labelText: 'Engenheiro',
      ),
      onSaved: (value) => _engineer = bloc.getUserId(value),
      validator: (value) => bloc.validateUser(value, "usuario informado não é valido"),
    );
  }

  TextFormField builderField() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.person),
        hintText: 'Insira o usuário do mestre de obras ',
        labelText: 'Mestre de obra *',
      ),
      onSaved: (value) => _builder = bloc.getUserId(value),
      validator: (value) => bloc.validateUser(value, "usuario informado não é valido"),
    );
  }

  TextFormField zipCodeField() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.location_searching),
        hintText: 'Insira o CEP da obra',
        labelText: 'CEP *',
      ),
      onSaved: (value) => _zipCode = value,
      validator: (value) => bloc.validateIsNull(value, "informe um cep"),
    );
  }

  TextFormField addressField() {
    return TextFormField(
      maxLength: 25,
      decoration: const InputDecoration(
        icon: Icon(Icons.add_location),
        hintText: 'Insira o endereço da obra',
        labelText: 'Endereço *',
      ),
      onSaved: (value) => _address = value,
      validator: (value) => bloc.validateIsNull(value, "Informe um endereço"),
    );
  }

  TextFormField nameField() {
    return TextFormField(
      maxLength: 12,
      decoration: const InputDecoration(
        icon: Icon(Icons.add_location),
        hintText: 'Insira um nome para obra',
        labelText: 'Nome *',
      ),
      onSaved: (value) => _name = value,
      validator: (value) =>
          bloc.validateIsNull(value, 'Informe um nome para obra'),
    );
  }

  TextFormField sizeField() {
    return TextFormField(
      decoration: const InputDecoration(
        icon: Icon(Icons.photo_size_select_small),
        hintText: 'Insira o tamanho da obra',
        labelText: 'Tamanho *',
      ),
      validator: (value) =>
          bloc.validateIsNull(value, 'Informe o tamanho da obra'),
      onSaved: (value) => _buildSize = double.parse(value),
      keyboardType: TextInputType.number,
    );
  }
}
