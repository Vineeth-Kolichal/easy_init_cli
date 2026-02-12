String spaceContent = '''
import 'package:flutter/material.dart';

class Space {
  static SizedBox x(double width) => SizedBox(
        width: width,
      );
  static SizedBox y(double height) => SizedBox(
        height: height,
      );
}
''';

String loadingContent = '''
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../core/extensions/extensions.dart';
import '../../core/theme/app_colors.dart';

class Loading extends StatelessWidget {
  ///Example:
  ///-------------------------
  ///```
  /// class HomeScreen extends StatelessWidget {
  ///   const HomeScreen({super.key});
  ///   @override
  ///   Widget build(BuildContext context) {
  ///     return Scaffold(
  ///       appBar: AppBar(
  ///         title: const Text("Home Screen"),
  ///       ),
  ///       body: const Loading(
  ///         isLoading: true // your loding contidtion here
  ///         child: MyUI(), //code for your screen UI,
  ///       ),
  ///     );
  ///   }
  /// }
  /// ```
  const Loading({
    super.key,
    required this.child,
    required this.isLoading,
  });
  final Widget child;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    AppColors? appColors = context.appColors;

    return Stack(
      children: [
        child,
        if (isLoading)
          Container(
            color: appColors?.kBlack.withOpacity(0.3),
            child: Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                height: 70,
                decoration: BoxDecoration(
                  color: appColors?.surfaceColor,
                  borderRadius: BorderRadius.circular(7),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Platform.isIOS
                        ? const CupertinoActivityIndicator(
                            radius: 15,
                          )
                        : const CircularProgressIndicator(
                            strokeWidth: 2,
                          ),
                    15.horizontalSpace,
                    Text(
                      "Please Wait...",
                      style: context.labelLarge(),
                    )
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}


''';

String responsiveContent = '''
import 'package:flutter/material.dart';

class Responsive extends StatelessWidget {
  const Responsive(
      {super.key, required this.desktop, this.tablet, required this.mobile});
  final Widget desktop;
  final Widget? tablet;
  final Widget mobile;

  static bool isMobile(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width < 500;
  }

  static bool isTabltet(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width > 500 && width < 1024;
  }

  static bool isDestop(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return width >= 1024;
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 1024) {
          return desktop;
        } else if (constraints.maxWidth > 500 && constraints.maxWidth < 1024) {
          return tablet == null ? mobile : tablet!;
        } else {
          return mobile;
        }
      },
    );
  }
}''';

String genericButtonContent = '''
import 'package:flutter/material.dart';
import '../../core/extensions/extensions.dart';

class GenericButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double width;
  final double height;
  final double borderRadius;
  final bool isLoading;
  final IconData? icon;

  const GenericButton({
    super.key,
    required this.onPressed,
    required this.text,
    this.backgroundColor,
    this.foregroundColor,
    this.width = double.infinity,
    this.height = 56,
    this.borderRadius = 16,
    this.isLoading = false,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    final primary = backgroundColor ?? colors?.primary ?? Colors.green;
    final onPrimary = foregroundColor ?? Colors.white;

    return SizedBox(
      width: width,
      height: height,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style:
            ElevatedButton.styleFrom(
              backgroundColor: primary,
              foregroundColor: onPrimary,
              elevation: 0,
              shadowColor: primary.withValues(alpha: 0.3),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ).copyWith(
              shadowColor: WidgetStateProperty.all(
                primary.withValues(alpha: 0.3),
              ),
              elevation: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.hovered) && !isLoading) {
                  return 8;
                }
                return 0;
              }),
            ),
        child: isLoading
            ? SizedBox(
                height: 24,
                width: 24,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(onPrimary),
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    text,
                    style: context
                        .labelLarge(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: onPrimary,
                        )
                        .copyWith(letterSpacing: 0.5),
                  ),
                  if (icon != null) ...[
                    const SizedBox(width: 8),
                    Icon(icon, color: onPrimary, size: 20),
                  ],
                ],
              ),
      ),
    );
  }
}
''';

String customTextFieldContent = '''
import 'package:flutter/material.dart';
import '../../core/extensions/extensions.dart';

class CustomTextField extends FormField<String> {
  final TextEditingController controller;
  final String hintText;
  final IconData? icon;
  final Widget? suffixIcon;
  final String? label;
  final bool isPassword;
  final bool isPasswordVisible;
  final VoidCallback? onVisibilityToggle;
  final Color? primaryColor;
  final Color? surfaceColor;
  final Color? onSurfaceColor;
  final TextInputType? keyboardType;
  final int? maxLines;

  CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    this.icon,
    this.suffixIcon,
    this.label,
    this.isPassword = false,
    this.isPasswordVisible = false,
    this.onVisibilityToggle,
    this.primaryColor,
    this.surfaceColor,
    this.onSurfaceColor,
    this.keyboardType,
    super.validator,
    this.maxLines,
  }) : super(
         initialValue: controller.text,
         autovalidateMode: AutovalidateMode.onUserInteraction,
         builder: (FormFieldState<String> state) {
           return Builder(
             builder: (context) {
               final colors = context.appColors;
               final primary = primaryColor ?? colors?.primary ?? Colors.green;
               final onSurface =
                   onSurfaceColor ??
                   colors?.onSurface ??
                   Theme.of(context).colorScheme.onSurface;
               final errorColor =
                   colors?.errorRed ?? Theme.of(context).colorScheme.error;

               return Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   if (label != null) ...[
                     Align(
                       alignment: Alignment.centerLeft,
                       child: Padding(
                         padding: const EdgeInsets.only(left: 4),
                         child: Text(
                           label.toUpperCase(),
                           style: context.labelMedium(
                             color: onSurface.withValues(alpha: 0.8),
                             fontWeight: FontWeight.w500,
                           ),
                         ),
                       ),
                     ),
                     const SizedBox(height: 8),
                   ],
                   Container(
                     decoration: BoxDecoration(
                       borderRadius: BorderRadius.circular(16),
                       border: Border.all(
                         color: onSurface.withValues(alpha: 0.5),
                       ),
                     ),
                     child: TextField(
                       maxLines: isPassword ? 1 : maxLines,
                       controller: controller,
                       keyboardType: keyboardType,
                       obscureText: isPassword && !isPasswordVisible,
                       style: context.bodyMedium(color: onSurface),
                       cursorColor: primary,
                       onChanged: (text) {
                         state.didChange(text);
                       },
                       decoration: InputDecoration(
                         hintText: hintText,
                         hintStyle: context.bodyMedium(
                           color: onSurface.withValues(alpha: 0.5),
                         ),
                         prefixIcon: icon != null
                             ? Icon(
                                 icon,
                                 color: onSurface.withValues(alpha: 0.4),
                               )
                             : null,
                         suffixIcon:
                             suffixIcon ??
                             (isPassword
                                 ? IconButton(
                                     icon: Icon(
                                       isPasswordVisible
                                           ? Icons.visibility
                                           : Icons.visibility_off,
                                       color: onSurface.withValues(alpha: 0.4),
                                     ),
                                     onPressed: onVisibilityToggle,
                                   )
                                 : null),
                         border: InputBorder.none,
                         contentPadding: const EdgeInsets.symmetric(
                           horizontal: 16,
                           vertical: 16,
                         ),
                         enabledBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(16),
                           borderSide: const BorderSide(
                             color: Colors.transparent,
                           ),
                         ),
                         focusedBorder: OutlineInputBorder(
                           borderRadius: BorderRadius.circular(16),
                           borderSide: BorderSide(color: primary, width: 1.0),
                         ),
                       ),
                     ),
                   ),
                   if (state.hasError)
                     Padding(
                       padding: const EdgeInsets.only(top: 6.0, left: 4.0),
                       child: Text(
                         state.errorText!,
                         style: context.labelSmall(color: errorColor),
                       ),
                     ),
                 ],
               );
             },
           );
         },
       );
}
''';
