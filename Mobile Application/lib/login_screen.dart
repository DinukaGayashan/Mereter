import 'package:cloud_functions/cloud_functions.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:glass/src/GlassWidget.dart';
import 'package:mereter/main_menu_loading_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

const TextStyle textStyle = TextStyle(
  fontSize: 20,
  fontFamily: 'SF Pro Display',
);

const TextStyle textStyle2 = TextStyle(
  fontSize: 20,
  fontFamily: 'SF Pro Display',
  color: Colors.white,
);

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);
  static const String id = 'loginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String email, password;
  final _auth = FirebaseAuth.instance;
  bool _isChecked = false;
  bool _passwordVisible = false;

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    _loadUserEmailPassword();
    super.initState();
  }

  void _loadUserEmailPassword() async {
    try {
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      var _email = _prefs.getString("email") ?? "";
      var _password = _prefs.getString("password") ?? "";
      var _rememberMe = _prefs.getBool("remember_me") ?? false;

      if (_rememberMe) {
        setState(() {
          _isChecked = true;
        });
        _emailController.text = _email;
        _passwordController.text = _password;
      }
    } catch (e) {
      var snackBar2 = SnackBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15))),
        behavior: SnackBarBehavior.floating,
        content: Text(
          e.toString(),
          style: textStyle2,
        ),
        backgroundColor: const Color(0xfffa4e4e),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
    }
  }

  void _handleRememberMe(bool value) {
    _isChecked = value;
    SharedPreferences.getInstance().then(
      (prefs) {
        prefs.setBool("remember_me", value);
        prefs.setString('email', _emailController.text);
        prefs.setString('password', _passwordController.text);
      },
    );
    setState(() {
      _isChecked = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: NetworkImage(
                'https://firebasestorage.googleapis.com/v0/b/mereter-35f11.appspot.com/o/backdrop.png?alt=media&token=643db69d-e72b-4303-ae4d-f73b6698241c'),
            fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Image.network(
                  'https://firebasestorage.googleapis.com/v0/b/mereter-35f11.appspot.com/o/Logo.png?alt=media&token=854a3612-69d1-4697-92b6-d934d54563c5'),
              const Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 60,
                  fontFamily: 'SF Pro Display',
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 30.0,
              ),
              TextField(
                controller: _emailController,
                style: textStyle,
                keyboardType: TextInputType.emailAddress,
                textAlign: TextAlign.center,
                decoration: const InputDecoration(
                  hintText: 'Enter your email',
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ).asGlass(clipBorderRadius: BorderRadius.circular(32)),
              const SizedBox(
                height: 8.0,
              ),
              TextField(
                controller: _passwordController,
                style: textStyle,
                obscureText: !_passwordVisible,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                      icon: Icon(_passwordVisible
                          ? Icons.visibility
                          : Icons.visibility_off_outlined)),
                  hintText: 'Enter your password.',
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 10.0, horizontal: 20.0),
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 1.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide:
                        BorderSide(color: Colors.lightBlueAccent, width: 2.0),
                    borderRadius: BorderRadius.all(Radius.circular(32.0)),
                  ),
                ),
              ).asGlass(clipBorderRadius: BorderRadius.circular(32)),
              const SizedBox(
                height: 24.0,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 16.0),
                child: Material(
                  color: Colors.lightBlueAccent,
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      email = _emailController.text;
                      password = _passwordController.text;
                      try {
                        HttpsCallable checkUserRole = FirebaseFunctions.instance
                            .httpsCallable('checkUserRole');
                        final result =
                            await checkUserRole.call(<String, dynamic>{
                          'email': email,
                        });

                        if (result.data.toString() != 'Patient') {
                          throw Exception('You are not a Registered Patient');
                        }
                        await _auth.signInWithEmailAndPassword(
                            email: email, password: password);
                        Navigator.pushNamed(context, MainMenuLoadingScreen.id);
                      } catch (e) {
                        var snackBar2 = SnackBar(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            e.toString(),
                            style: textStyle2,
                          ),
                          backgroundColor: const Color(0xfffa4e4e),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                      }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: const Text(
                      'Log In',
                      style: textStyle2,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 1.0),
                child: Material(
                  color: const Color(0xffeeeeee),
                  borderRadius: const BorderRadius.all(Radius.circular(30.0)),
                  elevation: 5.0,
                  child: MaterialButton(
                    onPressed: () async {
                      //Implement login functionality.
                      try {
                        const snackBar0 = SnackBar(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Color(0xff0c6505),
                            content: Text(
                              'Please wait.',
                              style: textStyle2,
                            ));
                        ScaffoldMessenger.of(context).showSnackBar(snackBar0);

                        const snackBar = SnackBar(
                            shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15))),
                            behavior: SnackBarBehavior.floating,
                            backgroundColor: Color(0xff0c6505),
                            content: Text(
                              'Password reset email sent successfully.',
                              style: textStyle2,
                            ));
                        await _auth.sendPasswordResetEmail(email: email);
                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                      } catch (e) {
                        var snackBar2 = SnackBar(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(15))),
                          behavior: SnackBarBehavior.floating,
                          content: Text(
                            e.toString(),
                            style: textStyle2,
                          ),
                          backgroundColor: const Color(0xfffa4e4e),
                        );
                        ScaffoldMessenger.of(context).showSnackBar(snackBar2);
                      }
                    },
                    minWidth: 200.0,
                    height: 42.0,
                    child: const Text(
                      'Forgot Password',
                      style: textStyle,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                SizedBox(
                    height: 24.0,
                    width: 24.0,
                    child: Theme(
                      data: ThemeData(
                          unselectedWidgetColor:
                              const Color(0xff00C8E8) // Your color
                          ),
                      child: Checkbox(
                          activeColor: const Color(0xff00C8E8),
                          value: _isChecked,
                          onChanged: (bool? value) {
                            _handleRememberMe(value!);
                          }),
                    )),
                const SizedBox(width: 15.0),
                const Text("Remember Me",
                    style: TextStyle(
                        color: Color(0xff646464),
                        fontSize: 20,
                        fontFamily: 'SF Pro Display'))
              ])
            ],
          ),
        ),
      ),
    );
  }
}
