import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CustomTextFields extends ConsumerStatefulWidget {
  const CustomTextFields({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _CustomTextFieldsState();
}

class _CustomTextFieldsState extends ConsumerState<CustomTextFields> {
  final TextEditingController todoTextController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    todoTextController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: TextField(
        controller: todoTextController,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
