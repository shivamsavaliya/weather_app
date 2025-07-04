import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BlurBox extends StatelessWidget {
  const BlurBox({
    super.key,
    required this.name,
    required this.value,
  });

  final String name;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(4),
      child: BlurryContainer(
        blur: 8,
        color: Colors.white10,
        padding: const EdgeInsets.all(4),
        width: MediaQuery.of(context).size.width / 1.2,
        borderRadius: BorderRadius.circular(20),
        child: ListTile(
          title: Text(
            name,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
          trailing: Text(
            value,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
