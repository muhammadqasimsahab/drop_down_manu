import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DropDown extends StatelessWidget {
  BookController bookcontroller = BookController();
  DropDown({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() => DropdownButton(
            hint: const Text(
              'Book Type',
            ),
            onChanged: (newValue) {
              bookcontroller.setSelected(newValue!);
            },
            value: bookcontroller.selected.value,
            items: bookcontroller.listType.map((selectedType) {
              return DropdownMenuItem(
                child: Text(
                  selectedType,
                ),
                value: selectedType,
              );
            }).toList(),
          )),
    );
  }
}

class BookController extends GetxController {
  // It is mandatory initialize with one value from listType
  final selected = "some book type".obs;
  var listType;

  void setSelected(String value) {
    selected.value = value;
  }
}
