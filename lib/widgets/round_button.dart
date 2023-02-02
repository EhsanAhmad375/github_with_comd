import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class RoundButton extends StatelessWidget {
  final String Title;
  final Color color;
  final bool loading;
  final VoidCallback onTap;
  const RoundButton({
    super.key,
    required this.Title,
    required this.color,
    this.loading = false,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: loading
                ? CircularProgressIndicator(
                    strokeWidth: 3,
                    color: Colors.white,
                  )
                : Text(
                    Title,
                    style: TextStyle(fontSize: 20),
                  ),
          ),
        ),
      ),
    );
  }
}
