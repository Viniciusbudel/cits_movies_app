
enum UIError {
  requiredField,
  invalidField,
  unexpected,
  invalidCredentials,
  emailInUse

}

extension UIErrorExtension on UIError {
  String get description {
    switch(this) {
      case UIError.invalidField: return 'Campo inválido';
      default: return 'Erro inesperado';
    }
  }
}