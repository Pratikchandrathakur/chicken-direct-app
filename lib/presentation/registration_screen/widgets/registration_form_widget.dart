import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sizer/sizer.dart';

import '../../../core/app_export.dart';

class RegistrationFormWidget extends StatefulWidget {
  final Function(Map<String, String>) onFormSubmit;
  final bool isLoading;

  const RegistrationFormWidget({
    Key? key,
    required this.onFormSubmit,
    required this.isLoading,
  }) : super(key: key);

  @override
  State<RegistrationFormWidget> createState() => _RegistrationFormWidgetState();
}

class _RegistrationFormWidgetState extends State<RegistrationFormWidget> {
  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  final _fullNameFocus = FocusNode();
  final _emailFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _passwordFocus = FocusNode();
  final _confirmPasswordFocus = FocusNode();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;
  bool _agreeToTerms = false;
  String _selectedCountryCode = '+1';

  // Validation states
  bool _fullNameValid = false;
  bool _emailValid = false;
  bool _phoneValid = false;
  bool _passwordValid = false;
  bool _confirmPasswordValid = false;

  // Password strength
  double _passwordStrength = 0.0;
  String _passwordStrengthText = '';

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _fullNameFocus.dispose();
    _emailFocus.dispose();
    _phoneFocus.dispose();
    _passwordFocus.dispose();
    _confirmPasswordFocus.dispose();
    super.dispose();
  }

  bool get _isFormValid =>
      _fullNameValid &&
      _emailValid &&
      _phoneValid &&
      _passwordValid &&
      _confirmPasswordValid &&
      _agreeToTerms;

  void _validateFullName(String value) {
    setState(() {
      _fullNameValid =
          value.trim().length >= 2 && value.trim().split(' ').length >= 2;
    });
  }

  void _validateEmail(String value) {
    setState(() {
      _emailValid = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value);
    });
  }

  void _validatePhone(String value) {
    setState(() {
      _phoneValid = value.replaceAll(RegExp(r'[^\d]'), '').length >= 10;
    });
  }

  void _validatePassword(String value) {
    setState(() {
      _passwordValid = value.length >= 8;
      _passwordStrength = _calculatePasswordStrength(value);
      _passwordStrengthText = _getPasswordStrengthText(_passwordStrength);
    });
  }

  void _validateConfirmPassword(String value) {
    setState(() {
      _confirmPasswordValid =
          value == _passwordController.text && value.isNotEmpty;
    });
  }

  double _calculatePasswordStrength(String password) {
    if (password.isEmpty) return 0.0;

    double strength = 0.0;

    // Length check
    if (password.length >= 8) strength += 0.25;
    if (password.length >= 12) strength += 0.25;

    // Character variety checks
    if (RegExp(r'[a-z]').hasMatch(password)) strength += 0.125;
    if (RegExp(r'[A-Z]').hasMatch(password)) strength += 0.125;
    if (RegExp(r'[0-9]').hasMatch(password)) strength += 0.125;
    if (RegExp(r'[!@#$%^&*(),.?":{}|<>]').hasMatch(password)) strength += 0.125;

    return strength.clamp(0.0, 1.0);
  }

  String _getPasswordStrengthText(double strength) {
    if (strength < 0.25) return 'Weak';
    if (strength < 0.5) return 'Fair';
    if (strength < 0.75) return 'Good';
    return 'Strong';
  }

  Color _getPasswordStrengthColor(double strength) {
    if (strength < 0.25) return AppTheme.lightTheme.colorScheme.error;
    if (strength < 0.5) return AppTheme.warningLight;
    if (strength < 0.75) return AppTheme.secondaryLight;
    return AppTheme.successLight;
  }

  void _submitForm() {
    if (_isFormValid) {
      final formData = {
        'fullName': _fullNameController.text.trim(),
        'email': _emailController.text.trim(),
        'phone': '$_selectedCountryCode${_phoneController.text.trim()}',
        'password': _passwordController.text,
      };
      widget.onFormSubmit(formData);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Full Name Field
          _buildInputField(
            controller: _fullNameController,
            focusNode: _fullNameFocus,
            nextFocusNode: _emailFocus,
            label: 'Full Name',
            hintText: 'Enter your full name',
            prefixIcon: 'person',
            keyboardType: TextInputType.name,
            textCapitalization: TextCapitalization.words,
            onChanged: _validateFullName,
            isValid: _fullNameValid,
            errorText: _fullNameController.text.isNotEmpty && !_fullNameValid
                ? 'Please enter your first and last name'
                : null,
          ),

          SizedBox(height: 4.h),

          // Email Field
          _buildInputField(
            controller: _emailController,
            focusNode: _emailFocus,
            nextFocusNode: _phoneFocus,
            label: 'Email Address',
            hintText: 'Enter your email address',
            prefixIcon: 'email',
            keyboardType: TextInputType.emailAddress,
            onChanged: _validateEmail,
            isValid: _emailValid,
            errorText: _emailController.text.isNotEmpty && !_emailValid
                ? 'Please enter a valid email address'
                : null,
          ),

          SizedBox(height: 4.h),

          // Phone Number Field with Country Code
          _buildPhoneField(),

          SizedBox(height: 4.h),

          // Password Field
          _buildPasswordField(),

          SizedBox(height: 2.h),

          // Password Strength Indicator
          if (_passwordController.text.isNotEmpty)
            _buildPasswordStrengthIndicator(),

          SizedBox(height: 4.h),

          // Confirm Password Field
          _buildInputField(
            controller: _confirmPasswordController,
            focusNode: _confirmPasswordFocus,
            label: 'Confirm Password',
            hintText: 'Re-enter your password',
            prefixIcon: 'lock',
            obscureText: _obscureConfirmPassword,
            onChanged: _validateConfirmPassword,
            isValid: _confirmPasswordValid,
            errorText: _confirmPasswordController.text.isNotEmpty &&
                    !_confirmPasswordValid
                ? 'Passwords do not match'
                : null,
            suffixIcon: IconButton(
              icon: CustomIconWidget(
                iconName:
                    _obscureConfirmPassword ? 'visibility' : 'visibility_off',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
              onPressed: () {
                setState(() {
                  _obscureConfirmPassword = !_obscureConfirmPassword;
                });
              },
            ),
            textInputAction: TextInputAction.done,
            onSubmitted: (_) => _submitForm(),
          ),

          SizedBox(height: 6.h),

          // Terms and Privacy Agreement
          _buildTermsAgreement(),

          SizedBox(height: 6.h),

          // Create Account Button
          _buildCreateAccountButton(),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required FocusNode focusNode,
    FocusNode? nextFocusNode,
    required String label,
    required String hintText,
    required String prefixIcon,
    TextInputType keyboardType = TextInputType.text,
    TextCapitalization textCapitalization = TextCapitalization.none,
    bool obscureText = false,
    Function(String)? onChanged,
    bool isValid = false,
    String? errorText,
    Widget? suffixIcon,
    TextInputAction textInputAction = TextInputAction.next,
    Function(String)? onSubmitted,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTheme.lightTheme.textTheme.labelLarge,
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: controller,
          focusNode: focusNode,
          keyboardType: keyboardType,
          textCapitalization: textCapitalization,
          obscureText: obscureText,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted ??
              (nextFocusNode != null
                  ? (_) => FocusScope.of(context).requestFocus(nextFocusNode)
                  : null),
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: prefixIcon,
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
            suffixIcon: controller.text.isNotEmpty && isValid
                ? Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: 'check_circle',
                      color: AppTheme.successLight,
                      size: 20,
                    ),
                  )
                : suffixIcon,
          ),
        ),
        if (errorText != null) ...[
          SizedBox(height: 1.h),
          Text(
            errorText,
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Phone Number',
          style: AppTheme.lightTheme.textTheme.labelLarge,
        ),
        SizedBox(height: 1.h),
        Row(
          children: [
            // Country Code Selector
            Container(
              width: 20.w,
              child: DropdownButtonFormField<String>(
                value: _selectedCountryCode,
                decoration: InputDecoration(
                  contentPadding:
                      EdgeInsets.symmetric(horizontal: 3.w, vertical: 4.w),
                ),
                items: [
                  DropdownMenuItem(value: '+1', child: Text('+1')),
                  DropdownMenuItem(value: '+44', child: Text('+44')),
                  DropdownMenuItem(value: '+91', child: Text('+91')),
                  DropdownMenuItem(value: '+86', child: Text('+86')),
                  DropdownMenuItem(value: '+33', child: Text('+33')),
                ],
                onChanged: (value) {
                  setState(() {
                    _selectedCountryCode = value!;
                  });
                },
              ),
            ),
            SizedBox(width: 2.w),
            // Phone Number Input
            Expanded(
              child: TextFormField(
                controller: _phoneController,
                focusNode: _phoneFocus,
                keyboardType: TextInputType.phone,
                textInputAction: TextInputAction.next,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(15),
                ],
                onChanged: _validatePhone,
                onFieldSubmitted: (_) =>
                    FocusScope.of(context).requestFocus(_passwordFocus),
                decoration: InputDecoration(
                  hintText: 'Enter phone number',
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(3.w),
                    child: CustomIconWidget(
                      iconName: 'phone',
                      color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                      size: 20,
                    ),
                  ),
                  suffixIcon: _phoneController.text.isNotEmpty && _phoneValid
                      ? Padding(
                          padding: EdgeInsets.all(3.w),
                          child: CustomIconWidget(
                            iconName: 'check_circle',
                            color: AppTheme.successLight,
                            size: 20,
                          ),
                        )
                      : null,
                ),
              ),
            ),
          ],
        ),
        if (_phoneController.text.isNotEmpty && !_phoneValid) ...[
          SizedBox(height: 1.h),
          Text(
            'Please enter a valid phone number (minimum 10 digits)',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPasswordField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Password',
          style: AppTheme.lightTheme.textTheme.labelLarge,
        ),
        SizedBox(height: 1.h),
        TextFormField(
          controller: _passwordController,
          focusNode: _passwordFocus,
          obscureText: _obscurePassword,
          textInputAction: TextInputAction.next,
          onChanged: _validatePassword,
          onFieldSubmitted: (_) =>
              FocusScope.of(context).requestFocus(_confirmPasswordFocus),
          decoration: InputDecoration(
            hintText: 'Create a strong password',
            prefixIcon: Padding(
              padding: EdgeInsets.all(3.w),
              child: CustomIconWidget(
                iconName: 'lock',
                color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                size: 20,
              ),
            ),
            suffixIcon: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_passwordController.text.isNotEmpty && _passwordValid)
                  Padding(
                    padding: EdgeInsets.only(right: 2.w),
                    child: CustomIconWidget(
                      iconName: 'check_circle',
                      color: AppTheme.successLight,
                      size: 20,
                    ),
                  ),
                IconButton(
                  icon: CustomIconWidget(
                    iconName:
                        _obscurePassword ? 'visibility' : 'visibility_off',
                    color: AppTheme.lightTheme.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
        if (_passwordController.text.isNotEmpty && !_passwordValid) ...[
          SizedBox(height: 1.h),
          Text(
            'Password must be at least 8 characters long',
            style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
              color: AppTheme.lightTheme.colorScheme.error,
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildPasswordStrengthIndicator() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'Password Strength: ',
              style: AppTheme.lightTheme.textTheme.bodySmall,
            ),
            Text(
              _passwordStrengthText,
              style: AppTheme.lightTheme.textTheme.bodySmall?.copyWith(
                color: _getPasswordStrengthColor(_passwordStrength),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
        SizedBox(height: 1.h),
        LinearProgressIndicator(
          value: _passwordStrength,
          backgroundColor:
              AppTheme.lightTheme.colorScheme.outline.withValues(alpha: 0.3),
          valueColor: AlwaysStoppedAnimation<Color>(
            _getPasswordStrengthColor(_passwordStrength),
          ),
        ),
      ],
    );
  }

  Widget _buildTermsAgreement() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Checkbox(
          value: _agreeToTerms,
          onChanged: (value) {
            setState(() {
              _agreeToTerms = value ?? false;
            });
          },
        ),
        Expanded(
          child: GestureDetector(
            onTap: () {
              setState(() {
                _agreeToTerms = !_agreeToTerms;
              });
            },
            child: Padding(
              padding: EdgeInsets.only(top: 3.w),
              child: RichText(
                text: TextSpan(
                  style: AppTheme.lightTheme.textTheme.bodySmall,
                  children: [
                    TextSpan(text: 'I agree to the '),
                    TextSpan(
                      text: 'Terms of Service',
                      style: TextStyle(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                    TextSpan(text: ' and '),
                    TextSpan(
                      text: 'Privacy Policy',
                      style: TextStyle(
                        color: AppTheme.lightTheme.colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCreateAccountButton() {
    return SizedBox(
      width: double.infinity,
      height: 12.w,
      child: ElevatedButton(
        onPressed: _isFormValid && !widget.isLoading ? _submitForm : null,
        child: widget.isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 5.w,
                    height: 5.w,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  SizedBox(width: 3.w),
                  Text('Creating your account...'),
                ],
              )
            : Text('Create Account'),
      ),
    );
  }
}
