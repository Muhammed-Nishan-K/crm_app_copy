import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TextInputField extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final String? Function(String?)? validator;
  final bool obscureText;
  final Icon? prefixIcon;
  final bool isShaking; // Added to control shaking effect

  const TextInputField({
    super.key,
    required this.controller,
    required this.labelText,
    this.validator,
    this.obscureText = false,
    this.prefixIcon,
    this.isShaking = false, // Default is false
  });

  @override
  _TextInputFieldState createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shakeAnimation;
  bool _isPasswordVisible = false; // Added to manage password visibility

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );

    _shakeAnimation = Tween<double>(begin: 0.0, end: 10.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticIn,
      ),
    );

    if (widget.isShaking) {
      _startShaking();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _startShaking() {
    _controller.forward().then((_) {
      _controller.reverse();
    });
  }

  void _togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // AnimatedBuilder to create the shaking effect
        AnimatedBuilder(
          animation: _shakeAnimation,
          builder: (context, child) {
            return Transform.translate(
              offset: Offset(_shakeAnimation.value, 0),
              child: TextFormField(
                controller: widget.controller,
                decoration: InputDecoration(
                  labelText: widget.labelText,
                  border: OutlineInputBorder(),
                  prefixIcon: widget.prefixIcon,
                  // Add a suffix icon for showing/hiding password
                  suffixIcon: widget.obscureText
                      ? IconButton(
                          icon: Icon(
                            _isPasswordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: _togglePasswordVisibility,
                        )
                      : null,
                ),
                obscureText: widget.obscureText && !_isPasswordVisible,
                validator: widget.validator,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s')), // Deny spaces
                ],
              ),
            );
          },
        ),
        SizedBox(height: 8), // Spacing for better readability
        // Display error message in two lines if any
        ValidatorMessage(validator: widget.validator),
      ],
    );
  }
}

class ValidatorMessage extends StatelessWidget {
  final String? Function(String?)? validator;

  const ValidatorMessage({Key? key, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final field = context.findAncestorWidgetOfExactType<TextFormField>();
    final errorText = field?.validator!(field.controller?.text);

    return errorText != null && errorText.isNotEmpty
        ? Text(
            errorText,
            style: TextStyle(
              color: Colors.red,
              fontSize: 12.0,
            ),
            maxLines: 2, // Limit to 2 lines
            overflow: TextOverflow.ellipsis, // Handle overflow
          )
        : SizedBox.shrink(); // Show nothing if there's no error
  }
}
