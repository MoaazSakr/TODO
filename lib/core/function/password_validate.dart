 String? validatePassword(String? value) {
 RegExp passwordRegex = RegExp(r'^[\w]{6,}$');
 bool result = passwordRegex.hasMatch(value??'');
 return result ? null : 'Password must contain A-Z, a-z, 0-9 and at least 6 characters';
 }