import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../view/auth/whatsapp_vet/whatsapp_vet.dart';

class SignupController with ChangeNotifier {
  final _formKey = GlobalKey<FormState>();
  GlobalKey<FormState> get formKey => _formKey;

  final _nameController = TextEditingController();
  TextEditingController get nameController => _nameController;

  final _emailController = TextEditingController();
  TextEditingController get emailController => _emailController;

  final _passwordController = TextEditingController();
  TextEditingController get passwordController => _passwordController;

  final _confirmPasswordController = TextEditingController();
  TextEditingController get confirmPasswordController =>
      _confirmPasswordController;

  final _passwordFocusNode = FocusNode();
  FocusNode get passwordFocusNode => _passwordFocusNode;

  final _confirmPasswordFocusNode = FocusNode();
  FocusNode get confirmPasswordFocusNode => _confirmPasswordFocusNode;

  bool _isSigningIn = false;
  bool get isSigningIn => _isSigningIn;

  bool _obscureText = true;
  bool get obscureText => _obscureText;

  bool _obscureText2 = true;
  bool get obscureText2 => _obscureText2;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  startLoading() {
    _isLoading = true;
    notifyListeners();
  }

  stopLoading() {
    _isLoading = false;
    notifyListeners();
  }

  void togglePasswordVisibility() {
    _obscureText = !_obscureText;
    notifyListeners();
  }

  void togglePasswordVisibility2() {
    _obscureText2 = !_obscureText2;
    notifyListeners();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _passwordFocusNode.dispose();
    _confirmPasswordFocusNode.dispose();
    super.dispose();
  }

  bool validateAndSubmit() {
    if (!_formKey.currentState!.validate()) {
      return false;
    }
    return true;
  }

  void submit(BuildContext context) {
    startLoading();
    _isSigningIn = true;
    notifyListeners();
    Future.delayed(const Duration(seconds: 3), () {}).then((value) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const WhatsAppVet(),
        ),
      );
      stopLoading();
    });
  }

  //write validation method
  String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Name is required';
    }
    if (value.length < 3) {
      return 'Name must be at least 3 characters long';
    }
    if (!RegExp(r"^[a-zA-Z ]+$").hasMatch(value)) {
      return 'Name can only contain letters and spaces';
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    bool isValid =
        RegExp(r"^[a-zA-Z0-9.!#$%&'+/=?^_`{|}~-]+@a-zA-Z0-9?(?:.a-zA-Z0-9?)$")
            .hasMatch(value);
    if (isValid) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    // if (RegExp(r"^(?=.[a-z])(?=.[A-Z])(?=.*\d)[a-zA-Z\d]{8,}$")
    //     .hasMatch(value)) {
    //   return 'Password must contain at least one lowercase letter, one uppercase letter, and one digit';
    // }
    return null;
  }

  String? validateConfirmPassword(String? value, String? password) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }
}

final signupController =
    ChangeNotifierProvider.autoDispose<SignupController>((ref) {
  return SignupController();
});
