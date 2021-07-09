String checkEmail(String val) {
  if (val == null || val.isEmpty) return ' Please type your email';
  String reg =
      "^([a-z0-9A-Z]+[-|\\.]?)+[a-z0-9A-Z]@([a-z0-9A-Z]+(-[a-z0-9A-Z]+)?\\.)+[a-zA-Z]{2,}\$";
  if (!RegExp(reg).hasMatch(val))
    return 'Please enter a valid email address';
  else
    return null;
}

String checkPassWord(String val) {
  if (val == null || val.isEmpty) return 'Please type you password';
  if (val.length < 3)
    return 'please type a usefully password';
  else
    return null;
}
