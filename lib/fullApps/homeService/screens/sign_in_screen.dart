import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:prokit_flutter/fullApps/homeService/screens/otp_verification_screen.dart';
import 'package:prokit_flutter/fullApps/homeService/screens/sign_up_screen.dart';
import 'package:prokit_flutter/fullApps/homeService/utils/constant.dart';
import 'package:prokit_flutter/fullApps/homeService/utils/widgets.dart';
import 'package:prokit_flutter/main.dart';

import '../custom_widget/space.dart';
import '../utils/colors.dart';
import '../utils/images.dart';

class SignInScreen extends StatefulWidget {
  SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _loginFormKey = GlobalKey<FormState>();
  double screenHeight = 0.0;
  double screenWidth = 0.0;

  String? _selectedCountryCode = '+91';

  bool checkPhoneNumber(String phoneNumber) {
    String regexPattern = r'^(?:[+0][1-9])?[0-9]{10,12}$';
    var regExp = RegExp(regexPattern);

    if (phoneNumber.isEmpty) {
      return false;
    } else if (regExp.hasMatch(phoneNumber)) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return AnnotatedRegion(
      value: SystemUiOverlayStyle(statusBarIconBrightness: appStore.isDarkModeOn ? Brightness.light : Brightness.dark),
      child: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Space(60),
                  Text("Welcome back!", style: TextStyle(fontSize: mainTitleTextSize, fontWeight: FontWeight.bold)),
                  Space(8),
                  Text("Please Login to your account", style: TextStyle(fontSize: 14, color: subTitle)),
                  Space(16),
                  Image.asset(splash_logo, width: 100, height: 100, fit: BoxFit.cover),
                ],
              ),
              Space(70),
              Form(
                key: _loginFormKey,
                child: TextFormField(
                  keyboardType: TextInputType.phone,
                  style: TextStyle(fontSize: 16),
                  inputFormatters: [LengthLimitingTextInputFormatter(10)],
                  decoration: commonInputDecoration(
                    hintText: "Enter mobile number",
                    prefixIcon: CountryCodePicker(
                      onChanged: (CountryCode countryCode) {
                        setState(() {
                          _selectedCountryCode = countryCode.dialCode;
                        });
                      },
                      initialSelection: 'IN',
                      favorite: ['+91', 'IN'],
                      showCountryOnly: false,
                      showOnlyCountryWhenClosed: false,
                      alignLeft: false,
                    ),
                  ),
                ),
              ),
              Space(16),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(16),
                    textStyle: TextStyle(fontSize: 16),
                    shape: StadiumBorder(),
                    backgroundColor: appStore.isDarkModeOn ? Colors.grey.withOpacity(0.2) : Colors.black,
                  ),
                  onPressed: () {
                    if (_loginFormKey.currentState!.validate()) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OTPVerificationScreen()),
                      );
                    }
                  },
                  child: Text("Log In", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: Colors.white)),
                ),
              ),
              Space(32),
              GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpScreen()));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account?", style: TextStyle(fontSize: 16)),
                    Space(4),
                    Text('Sign Up', style: boldTextStyle()),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}