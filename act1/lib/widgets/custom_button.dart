import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

enum ButtonType { material, cupertino }

enum ButtonVariant { primary, secondary, outline }

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final ButtonVariant variant;
  final bool isLoading;
  final IconData? icon;
  final double? width;
  final double height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.material,
    this.variant = ButtonVariant.primary,
    this.isLoading = false,
    this.icon,
    this.width,
    this.height = 50.0,
  });

  @override
  Widget build(BuildContext context) {
    if (type == ButtonType.cupertino) {
      return _buildCupertinoButton(context);
    } else {
      return _buildMaterialButton(context);
    }
  }

  Widget _buildMaterialButton(BuildContext context) {
    Widget buttonChild = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(
                variant == ButtonVariant.primary
                    ? Colors.white
                    : Theme.of(context).primaryColor,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: 8),
              ],
              Text(text),
            ],
          );

    ButtonStyle style;
    switch (variant) {
      case ButtonVariant.primary:
        style = ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).primaryColor,
          foregroundColor: Colors.white,
          minimumSize: Size(width ?? 0, height),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
        break;
      case ButtonVariant.secondary:
        style = ElevatedButton.styleFrom(
          backgroundColor: Colors.grey[200],
          foregroundColor: Colors.black87,
          minimumSize: Size(width ?? 0, height),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
        break;
      case ButtonVariant.outline:
        style = OutlinedButton.styleFrom(
          foregroundColor: Theme.of(context).primaryColor,
          minimumSize: Size(width ?? 0, height),
          side: BorderSide(color: Theme.of(context).primaryColor),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        );
        break;
    }

    return SizedBox(
      width: width,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: style,
        child: buttonChild,
      ),
    );
  }

  Widget _buildCupertinoButton(BuildContext context) {
    Widget buttonChild = isLoading
        ? CupertinoActivityIndicator(
            color: variant == ButtonVariant.primary
                ? Colors.white
                : CupertinoColors.activeBlue,
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 18),
                const SizedBox(width: 8),
              ],
              Text(text),
            ],
          );

    Color backgroundColor;

    switch (variant) {
      case ButtonVariant.primary:
        backgroundColor = CupertinoColors.activeBlue;
        break;
      case ButtonVariant.secondary:
        backgroundColor = CupertinoColors.systemGrey5;
        break;
      case ButtonVariant.outline:
        backgroundColor = Colors.transparent;
        break;
    }

    return SizedBox(
      width: width,
      height: height,
      child: CupertinoButton(
        onPressed: isLoading ? null : onPressed,
        color: backgroundColor,
        borderRadius: BorderRadius.circular(8),
        child: buttonChild,
      ),
    );
  }
}
