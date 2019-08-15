import 'package:FPA/components/formInput.dart';
import 'package:FPA/components/solidButtons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  SignUp({Key key}) : super(key: key);

  @override
  SignUpState createState() => SignUpState();
}

class SignUpState extends State<SignUp> {
  final _formKey = GlobalKey<FormState>();

  String _email = "";
  String _password = "";
  String _username = "";

  final FocusNode _emailFocus = FocusNode();
  final FocusNode _passwordFocus = FocusNode();
  final FocusNode _repasswordFocus = FocusNode();
  final FocusNode _usernameFocus = FocusNode();
  TextEditingController _passwordController = new TextEditingController();

  UserData _data = new UserData();

  @override
  Widget build(BuildContext context) {
    _passwordController.addListener(onPasswordChange);

    return Scaffold(
      appBar: AppBar(
        title: Text("회원가입"),
        backgroundColor: Color(0xFF3B3E45),
        elevation: 0.0,
      ),
      backgroundColor: Color(0xFF3B3E45),
      body: Form(
        key: _formKey,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                MyInputFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    this._data._email = value;
                    setState(() {
                      _email = value;
                    });
                  },
                  labelText: "이메일(Email)",
                  hintText: "로그인과 인증에 사용할 이메일을 입력하세요",
                  autofocus: true,
                  keyboardType: TextInputType.emailAddress,
                  textInputType: TextInputAction.next,
                  focusNode: _emailFocus,
                  onFieldSubmitted: (term) {
                    _fieldFocusChange(context, _emailFocus, _passwordFocus);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: MyInputFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      this._data._password = value;
                      setState(() {
                        _password = value;
                      });
                    },
                    labelText: "비밀번호(Password)",
                    hintText: "비밀번호를 입력해주세요(6~20자 내)",
                    obsecureText: true,
                    textInputType: TextInputAction.next,
                    focusNode: _passwordFocus,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, _passwordFocus, _repasswordFocus);
                    },
                    controller: _passwordController,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: MyInputFormField(
                    validator: (value) {
                      if (value.isEmpty || _password != value) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    labelText: "비밀번호 재입력(Re-Password)",
                    hintText: "비밀번호를 다시 입력하세요",
                    obsecureText: true,
                    textInputType: TextInputAction.next,
                    focusNode: _repasswordFocus,
                    onFieldSubmitted: (term) {
                      _fieldFocusChange(
                          context, _repasswordFocus, _usernameFocus);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: MyInputFormField(
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please enter some text';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      this._data._username = value;
                      setState(() {
                        _username = value;
                      });
                    },
                    labelText: "이름(Username)",
                    hintText: "다른 사용자에게 보여질 이름을 적어주세요",
                    focusNode: _usernameFocus,
                    onFieldSubmitted: (term) {
                      _usernameFocus.unfocus();
                    },
                  ),
                ),
              ],
              crossAxisAlignment: CrossAxisAlignment.start,
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomSignUpSubmitButton(
        formKey: _formKey,
        userData: this._data,
      ),
    );
  }

  onPasswordChange() {
    String text = _passwordController.text;
    setState(() {
      _password = text;
    });
  }
}

class BottomSignUpSubmitButton extends StatelessWidget {
  BottomSignUpSubmitButton({@required this.formKey, @required this.userData});

  final GlobalKey<FormState> formKey;
  final UserData userData;

  @override
  Widget build(BuildContext context) {
    return SolidButton(
      text: "가입하기",
      onClick: () {
        if (formKey.currentState.validate()) {
          formKey.currentState.save();
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Valid!!"),
            ),
          );
        } else {
          Scaffold.of(context).showSnackBar(
            SnackBar(
              content: Text("Invalid!!"),
            ),
          );
        }
      },
    );
  }
}

_fieldFocusChange(
  BuildContext context,
  FocusNode currentFocus,
  FocusNode nextFocus,
) {
  currentFocus.unfocus();
  FocusScope.of(context).requestFocus(nextFocus);
}

class UserData {
  String _email = "";
  String _password = "";
  String _username = "";

  UserData({String email, String password, String username}) {
    this._email = email;
    this._password = password;
    this._username = username;
  }

  get email => _email;
  get password => _password;
  get username => _username;
}
