import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/constrant/app_style.dart';
import 'package:todoapp/widget/date_time_widget.dart';
import 'package:todoapp/widget/radio_widget.dart';
import 'package:todoapp/widget/textfield_widget.dart';


class AddNewTaskModel extends StatelessWidget {
  const AddNewTaskModel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(19),
      child: Container(
        padding: const EdgeInsets.all(25),
        height: MediaQuery.of(context).size.height * 0.70,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              width: double.infinity,
              child: Text(
                'Create New Task',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
              ), 
            ),

            const Gap(12),

            Divider(
              thickness: 1.2,
              color: Colors.grey.shade200,
            ),
            const Text('Title Task', style: AppStyle.headingOne,),
            const Gap(5),
            const TextFieldWidget(maxLines: 1, hintText: 'Add Task Name'),

            const Gap(13),

            const Text('Discription', style: AppStyle.headingOne,),
            const Gap(5),
            const TextFieldWidget(maxLines: 4, hintText: 'Add Detail Discription',),

            const Gap(13),

            const Text('Category', style: AppStyle.headingOne,),
            //const Gap(5),
            
            const Row(
                children: [
                  Expanded(child: RadioWidget(titleRadio: 'Learn', cateColor: Colors.green)),
              
                  Expanded(child: RadioWidget(titleRadio: 'Work', cateColor: Colors.blue)),
              
                  Expanded(child: RadioWidget(titleRadio: 'General', cateColor: Colors.orange)),
                ],
            ),

            const Gap(3),

            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                date_time_widget(title: 'Date', valueText: 'dd/mm/yyyy', icon: CupertinoIcons.calendar),
                
                Gap(50),

                date_time_widget(title: 'Time', valueText: 'hh : mm', icon: CupertinoIcons.clock),
                
              ],
            ),

            const Gap(20),

            Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue.shade800,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ), 
                    side: BorderSide(
                      color: Colors.blue.shade800,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {},
                  child: const Text('Cancel', style: TextStyle(fontSize: 15),),
                ),
              ), 

              const Gap(50),
              
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade800,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    side: BorderSide(
                      color: Colors.blue.shade800,
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 12),
                  ),
                  onPressed: () {},
                  child: const Text('Create', style: TextStyle(fontSize: 15),),
                ), 
              ), 
            ],
          ) 

          ],
        ),
      )
    );
  }
}





