
class CommonValidator {

  static bool validateEmail(String email){
    return !(CommonValidator.validateNotEmptyString(email) && RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email));
  }

  static bool validateNotEmptyString(String value ){
    return !(value == null || value.isEmpty);
  }

  static bool validateEmptyString(String value ){
    return (value == null || value.isEmpty);
  }

}