import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todoapp/provider/radio_provider.dart';

class RadioWidget extends ConsumerWidget {
  const RadioWidget({
    super.key,
    required this.titleRadio,
    required this.cateColor,
    required this.valueInput,
    required this.onChangedValue,
  });

  final String titleRadio;
  final Color cateColor;
  final int valueInput;
  final VoidCallback onChangedValue;

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final radio = ref.watch(radioProvider);

    return Material(
      child: Theme(
        data: ThemeData(unselectedWidgetColor: cateColor),
        child: RadioListTile(
        fillColor: MaterialStateColor.resolveWith((states) => cateColor),
        tileColor: Colors.white,
        activeColor: cateColor,
        contentPadding: EdgeInsets.zero,
        title: Transform.translate(
          offset: const Offset(-20, 0), child: Text(titleRadio, style: 
          TextStyle(color: cateColor, fontWeight: FontWeight.w700, fontSize: 15.5),), 
          ),
          value: valueInput,
          groupValue: radio,
          onChanged: (value) => onChangedValue(),
      ) 
      ),
    );
  }
}