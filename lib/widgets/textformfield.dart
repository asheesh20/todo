/*
import 'package:flutter/material.dart';

class MyWidget extends StatelessWidget {
  const MyWidget({super.key,required this.controller, required this.hintText});
  final TextEditingController controller;
  final String hintText;
  

  @override
  Widget build(BuildContext context) {
    return TextFormField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(color: Colors.grey[100]),
                      enabledBorder: const OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade100),
                      ),
                      fillColor: Colors.grey.shade200,
                      hintText: 'Enter Description here',
                      hintStyle: const TextStyle(fontWeight: FontWeight.normal),
                      filled: true,
                      //labelText: 'Title',
                    ),
                    enableSuggestions: false,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Please enter a description';
                      }
                      return null;
                    },
                    onSaved: (newValue) {
                      description = newValue!;
                    },
                  ),;
  }
}
*/