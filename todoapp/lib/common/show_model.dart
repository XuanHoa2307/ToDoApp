import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/constrant/app_style.dart';
import 'package:todoapp/provider/date_time_provider.dart';
import 'package:todoapp/provider/radio_provider.dart';
import 'package:todoapp/widget/date_time_widget.dart';
import 'package:todoapp/widget/radio_widget.dart';
import 'package:todoapp/widget/textfield_widget.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


class AddNewTaskModel extends ConsumerWidget {
  const AddNewTaskModel({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final dateProv = ref.watch(dateProvider);
    final timeProv = ref.watch(timeProvider);

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
            
            Row(
                children: [
                  Expanded(child: RadioWidget(titleRadio: 'Learn', cateColor: Colors.green,
                  valueInput: 1, onChangedValue: () => ref.read(radioProvider.notifier).update ((state) => 1)
                  )
                  ),
              
                  Expanded(child: RadioWidget(titleRadio: 'Work', cateColor: Colors.blue, 
                  valueInput: 2,onChangedValue: () => ref.read(radioProvider.notifier).update ((state) => 2)
                  )
                  ),
              
                  Expanded(child: RadioWidget(titleRadio: 'General', cateColor: Colors.orange, 
                  valueInput: 3, onChangedValue: () => ref.read(radioProvider.notifier).update ((state) => 3)
                  )
                  ),
                ],
            ),

            const Gap(3),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                DateTimeWidget(title: 'Date', valueText: dateProv, icon: CupertinoIcons.calendar,
                 onTap: () async {
                  final getValue = await showDatePicker(
                  context: context, 
                  initialDate: DateTime.now(),
                  firstDate: DateTime.now(),
                  lastDate: DateTime(2090),
                );

                if(getValue != null){
                    final format = DateFormat.yMd();
                    print(format.format(getValue));
                    ref
                        .read(dateProvider.notifier)
                        .update((state) => format.format(getValue));


                  }

                }
                ),
                
                const Gap(50),

                DateTimeWidget(title: 'Time', valueText: timeProv, icon: CupertinoIcons.clock,
                onTap: () async {
                  
                  final getTime = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now()
                    );

                  if(getTime != null){
                    ref
                        .read(timeProvider.notifier)
                        .update((state) => getTime.format(context));
                  }

                }
                ),
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
                  onPressed: () => Navigator.pop(context),
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





