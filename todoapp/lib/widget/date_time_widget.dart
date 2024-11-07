import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todoapp/constrant/app_style.dart';
import 'package:gap/gap.dart';

class date_time_widget extends StatelessWidget {
  const date_time_widget({
    super.key,
    required this.title,
    required this.valueText,
    required this.icon,
  });

  final String title;
  final String valueText;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return 
    Expanded(
      child:
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppStyle.headingOne),
              const Gap(5),
              
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(10),
                ),
                
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:[
                    Icon(icon),
                    const Gap(5),
                    Text(valueText),
                  ],)
                  ,)
            ],
            ),
        );
  }
}