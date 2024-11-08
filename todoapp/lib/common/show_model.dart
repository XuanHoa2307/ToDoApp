import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/constrant/app_style.dart';
import 'package:todoapp/model/todo_model.dart';
import 'package:todoapp/provider/date_time_provider.dart';
import 'package:todoapp/provider/radio_provider.dart';
import 'package:todoapp/provider/service_provider.dart';
import 'package:todoapp/services/notification_service.dart';
import 'package:todoapp/widget/date_time_widget.dart';
import 'package:todoapp/widget/radio_widget.dart';
import 'package:todoapp/widget/textfield_widget.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';


class AddNewTaskModel extends ConsumerStatefulWidget {
  const AddNewTaskModel({
    super.key,
    
  });

  @override
  ConsumerState<AddNewTaskModel> createState() => _AddNewTaskModelState();
}

class _AddNewTaskModelState extends ConsumerState<AddNewTaskModel> {

  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final NotificationService notificationService = NotificationService();

  @override
  void initState() {
    super.initState();
    notificationService.initializeNotifications();
  }

  /*@override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();
    super.dispose();
  }*/
  
  @override
  Widget build(BuildContext context) {

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
            TextFieldWidget(maxLines: 1, hintText: 'Add Task Name', txtController: titleController,),

            const Gap(13),

            const Text('Discription', style: AppStyle.headingOne,),
            const Gap(5),
            TextFieldWidget(maxLines: 4, hintText: 'Add Detail Discription', txtController: descriptionController,),

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
                    //print(format.format(getValue));
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
                  onPressed: () {
                  
                  final getRadioValue = ref.read(radioProvider);
                  if (titleController.text.trim().isEmpty || 
                      descriptionController.text.trim().isEmpty ||
                      getRadioValue == 0 ||
                      ref.read(dateProvider) == 'dd/mm/yyyy' ||
                      ref.read(timeProvider) == 'hh : mm') {
                        
                    
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: const Text('Warning'),
                        content: const Text('Please fill in all fields before creating task'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text('OK'),
                          ),
                        ],
                      ),
                    );
                    return;
                  }

                  
                  String category = '';
                  switch(getRadioValue) {
                    case 1:
                      category = 'Learn';
                      break;
                    case 2:
                      category = 'Work';
                      break;
                    case 3:
                      category = 'General';
                      break;
                  }

                  ref.read(serviceProvider).addNewTask(TodoModel(
                    titleTask: titleController.text,
                    description: descriptionController.text,
                    category: category,
                    dateTask: ref.read(dateProvider),
                    timeTask: ref.read(timeProvider),
                    isDone: false,
                  ));

                  notificationService.scheduleNotification(1,  ref.read(dateProvider), ref.read(timeProvider));

                  titleController.clear();
                  descriptionController.clear();
                  ref.read(radioProvider.notifier).update((state) => 0);
                  ref.read(dateProvider.notifier).update((state) => 'dd/mm/yyyy');
                  ref.read(timeProvider.notifier).update((state) => 'hh : mm');
                  Navigator.pop(context);
                },
                child: const Text('Create', style: TextStyle(fontSize: 15)),
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





