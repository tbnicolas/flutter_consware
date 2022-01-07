class Validator {

  /* Validacion del email y la contraseña lo que permite detener la accion de hacer un llamado a FireStore si no se cumplen con las reglas */

  bool emailValidator(String email){
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = RegExp(pattern);

    if(regExp.hasMatch(email)){
      return true;
    }else{
      return false;
    }
  }

  bool passwordValidator(String password) => ( password.length >= 6 );
  

}