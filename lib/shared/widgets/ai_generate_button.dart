import 'package:flutter/material.dart';

class AiGenerateButton extends StatelessWidget {
  const AiGenerateButton({
    super.key,
    required this.onPressed,
    this.isLoading = false,
    this.label = 'Generate dengan AI',
  });

  final VoidCallback? onPressed;
  final bool isLoading;
  final String label;

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return OutlinedButton.icon(
      onPressed: isLoading ? null : onPressed,
      style: OutlinedButton.styleFrom(
        foregroundColor: colorScheme.secondary,
        side: BorderSide(color: colorScheme.secondary),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      ),
      icon: isLoading
          ? SizedBox(
        width: 18,
        height: 18,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: colorScheme.secondary,
        ),
      )
          : const Icon(Icons.auto_awesome_rounded, size: 18),
      label: Text(isLoading ? 'Generating...' : label),
    );
  }
}