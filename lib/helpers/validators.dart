String validateEmail(String value) {
  Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = new RegExp(pattern);

  if (value.isEmpty)
    return "이메일을 입력해주세요.";
  else if (!regex.hasMatch(value)) return "유효하지 않은 이메일 입니다.";

  return null;
}

String validatePassword(String value) {
  if (value.isEmpty)
    return "비밀번호를 입력해주세요.";
  else if (value.length < 6 || value.length > 20) return "6~20 이내로 적어주세요";

  return null;
}

String validateUsername(String value) {
  if (value.isEmpty) {
    return "이름을 입력해주세요.";
  }
  return null;
}
