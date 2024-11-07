import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/constrant/app_style.dart';
import 'package:gap/gap.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


class DateTimeWidget extends ConsumerWidget {
  const DateTimeWidget({
    super.key,
    required this.title,
    required this.valueText,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String valueText;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return 
    Expanded(
      child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppStyle.headingOne),
              const Gap(5),
              
              Material(
                child: Ink(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(10)
                  ),
                  child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: onTap, //=> print('clicked'),
                  
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Icon(icon),
                        const Gap(5),
                        Text(valueText),
                      ],)
                      ,),
                )
                ),
              )
            ],
            ),
        );
  }
}