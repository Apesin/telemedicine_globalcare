import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

// const primaryColor = Color(0XFF11346a);
const primaryColor = Color(0XFF056AC8);
const textColor = Color(0xFF35364F);
const backgroundColor = Color(0xFFE6EFF9);
const redColor = Color(0xFFE85050);
const appColor = Color(0XFF11346a);

const defaultPadding = 16.0;

OutlineInputBorder textFieldBorder = OutlineInputBorder(
  borderSide: BorderSide(
    color: primaryColor.withOpacity(0.1),
  ),
);

// I will explain it later

const emailError = 'Enter a valid email address';
const requiredField = "This field is required";

final passwordValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'password is required'),
    MinLengthValidator(3, errorText: 'password must be at least 6 digits long'),
    // PatternValidator(r'(?=.*?[#?!@$%^&*-])',
    //     errorText: 'passwords must have at least one special character')
  ],
);

final usernameValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'username is required'),
  ],

);

final emrValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'EMR Card Number is required'),
  ],

);

final descriptionValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'description is required'),
  ],
);

final emailValidator = MultiValidator(
  [
    RequiredValidator(errorText: 'email is required'),
  ],
);


