import 'package:flutter/material.dart';

class InputValidation {
  TextEditingController? passwordController;
  InputValidation({this.passwordController});

  String? validateUsername(String? username) {
    if (username!.isEmpty) return "Please enter a username";
    // Step 1: Username must start with a letter
    const String startPattern = r"^[A-Za-z]";
    final RegExp startRegex = RegExp(startPattern);
    if (!startRegex.hasMatch(username[0])) {
      return 'Username must start with a letter';
    }

    // Step 2: Username can contain letters, digits, and underscores anywhere
    const String middlePattern = r"^[A-Za-z0-9_]+$";
    final RegExp middleRegex = RegExp(middlePattern);
    if (!middleRegex.hasMatch(username.substring(1))) {
      return 'Username can only contain letters, digits, and underscores';
    }

    // Step 3: Username must be between 7 and 29 characters long
    if (username.length < 7 || username.length > 29) {
      return 'Username must be between 7 and 29 characters long';
    }

    return null; // Username is valid
  }

  String? validateEmail(String? email) {
    if (email!.isEmpty) return "Please enter an email address";
    const pattern = r"(?:[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'"
        r'*+/=?^_`{|}~-]+)*|"(?:[\x01-\x08\x0b\x0c\x0e-\x1f\x21\x23-\x5b\x5d-'
        r'\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])*")@(?:(?:[a-z0-9](?:[a-z0-9-]*'
        r'[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?|\[(?:(?:(2(5[0-5]|[0-4]'
        r'[0-9])|1[0-9][0-9]|[1-9]?[0-9]))\.){3}(?:(2(5[0-5]|[0-4][0-9])|1[0-9]'
        r'[0-9]|[1-9]?[0-9])|[a-z0-9-]*[a-z0-9]:(?:[\x01-\x08\x0b\x0c\x0e-\x1f\'
        r'x21-\x5a\x53-\x7f]|\\[\x01-\x09\x0b\x0c\x0e-\x7f])+)\])';
    final regex = RegExp(pattern);
    return !regex.hasMatch(email.trim()) ? 'Enter a valid email address' : null;
  }

  String? validatePassword(String? password) {
    if (password!.isEmpty) {
      return 'Please enter password';
    } else {
      if (!RegExp(r'.{8,}').hasMatch(password)) {
        return 'Password must be at least 8 characters long';
      }
      if (!RegExp(r'.*[A-Z]').hasMatch(password)) {
        return 'Password must contain at least one uppercase letter';
      }
      if (!RegExp(r'.*[a-z]').hasMatch(password)) {
        return 'Password must contain at least one lowercase letter';
      }
      if (!RegExp(r'.*[0-9]').hasMatch(password)) {
        return 'Password must contain at least one digit';
      }
      if (!RegExp(r'.*[!@#\$&*~]').hasMatch(password)) {
        return 'Password must contain at least one special character';
      } else {
        return null; // Password meets all criteria
      }
    }
  }

  String? validateConfirmPassword(String? confirmPassword) {
    if (confirmPassword!.isEmpty) return "Please enter a password";
    if (passwordController!.text != confirmPassword) {
      return "Passwords don't match";
    }
    return null;
  }
}
