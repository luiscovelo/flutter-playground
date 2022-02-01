import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final void Function()? onTap;
  const CustomButtonWidget({Key? key, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        height: 54,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(13),
        ),
        child: const Icon(
          Icons.search,
          size: 32,
          color: Color(0xFFE78B90),
        ),
      ),
      onTap: onTap,
    );
  }
}
