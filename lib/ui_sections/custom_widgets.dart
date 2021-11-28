import 'package:active_ecommerce_flutter/helpers/responsive_helper.dart';
import 'package:flutter/material.dart';

//Custom TextFormField used in screens

class CustomTextField extends StatelessWidget {
  final IconData iconName;
  final String hintText;
  final TextEditingController controller;

  // ignore: use_key_in_widget_constructors
  const CustomTextField(this.hintText, this.iconName, this.controller);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: SizeConfig.blockSizeVertical * 10,
      child: TextField(
        decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(
              iconName,
              color: const Color(0xFF000000),
            ),
            hintStyle: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.black,
                fontSize: 12)),
        controller: controller,
      ),
    );
  }
}

//CustomButtons

class CustomButton extends StatelessWidget {
  final String buttonText;
  final IconData iconName;
  final VoidCallback onPressed;
  // ignore: use_key_in_widget_constructors
  const CustomButton(this.iconName, this.buttonText, this.onPressed);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(70, 15, 60, 15),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(buttonText.toUpperCase(),
                  style: const TextStyle(fontSize: 14, color: Colors.white)),
              SizedBox(
                width: SizeConfig.blockSizeHorizontal * 0.9,
              ),
              Icon(
                iconName,
                color: Colors.white,
              )
            ],
          ),
        ),
        style: ButtonStyle(
            foregroundColor: MaterialStateProperty.all<Color>(Colors.white),
            backgroundColor:
                MaterialStateProperty.all<Color>(Colors.indigo.shade900),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                    side: const BorderSide(color: Colors.indigo)))),
        onPressed: onPressed);
  }
}
