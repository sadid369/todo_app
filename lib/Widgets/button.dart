import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomButton extends ConsumerWidget {
  final IconData icon;
  final VoidCallback onTap;
  const CustomButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(minimumSize: const Size(55, 55)),
        child: Icon(icon),
      ),
    );
  }
}
