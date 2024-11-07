import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RadioWidget extends StatelessWidget {
  const RadioWidget({
    super.key,
    required this.titleRadio,
    required this.cateColor,
  });

  final String titleRadio;
  final Color cateColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Theme(
        data: ThemeData(unselectedWidgetColor: cateColor),
        child: RadioListTile(
        fillColor: MaterialStateColor.resolveWith((states) => cateColor),
        tileColor: Colors.white,
        contentPadding: EdgeInsets.zero,
        title: Transform.translate(
          offset: const Offset(-20, 0), child: Text(titleRadio, style: 
          TextStyle(color: cateColor, fontWeight: FontWeight.w700, fontSize: 15.5),), 
          ),
          value: 1,
          groupValue: 0,
          onChanged: (value) {},
      ) 
      ),
    );
  }
}