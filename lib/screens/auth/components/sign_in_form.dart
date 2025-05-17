import 'package:flutter/material.dart';
import 'package:form_field_validator/form_field_validator.dart';

import '../../../constants.dart';
import 'sign_up_form.dart';

class SignInForm extends StatelessWidget {
  SignInForm({
    Key? key,
    required this.formKey,
  }) : super(key: key);

  final GlobalKey formKey;

  late String _email, _password;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldName(text: "Username"),
          TextFormField(
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(hintText: "Enter your username"),
            validator: EmailValidator(errorText: "Use a valid username!"),
            onSaved: (email) => _email = email!,
          ),
          const SizedBox(height: defaultPadding),
          TextFieldName(text: "Password"),
          TextFormField(
            // We want to hide our password
            obscureText: true,
            decoration: InputDecoration(hintText: "******"),
            validator: passwordValidator,
            onSaved: (password) => _password = password!,
          ),
          const SizedBox(height: defaultPadding),
        ],
      ),
    );
  }
}
