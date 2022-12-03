import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

class ClassicTextFormField extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool isPassword;
  final bool isEmail;

  const ClassicTextFormField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.isEmail,
    required this.isPassword,
  });

  @override
  State<ClassicTextFormField> createState() => _ClassicTextFormFieldState();
}

class _ClassicTextFormFieldState extends State<ClassicTextFormField> {
  bool _passwordVisible = false;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType:
          widget.isEmail ? TextInputType.emailAddress : TextInputType.text,
      controller: widget.controller,
      obscureText: widget.isPassword ? !_passwordVisible : false,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (widget.isEmail) {
          return value != null && !EmailValidator.validate(value)
              ? 'Enter a valid email'
              : null;
        } else if (widget.isPassword) {
          return value != null && value.length < 8
              ? "Password need to be atleast 8 characters long"
              : null;
        } else {
          return value != null && value.isEmpty ? "Field is required" : null;
        }
      },
      decoration: InputDecoration(
        filled: true,
        hintText: widget.hintText,
        contentPadding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        enabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(5)),
        suffixIcon: widget.isPassword
            ? IconButton(
                icon: Icon(
                  _passwordVisible ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              )
            : null,
      ),
      style: const TextStyle(fontSize: 20),
    );
  }
}
