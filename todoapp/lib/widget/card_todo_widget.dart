import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gap/gap.dart';
import 'package:todoapp/provider/service_provider.dart';

class CardToDoListWidget extends ConsumerWidget {
  const CardToDoListWidget({
    super.key,
    required this.getIndex,
    required this.todoData,
  });

  final int getIndex;
  final List<dynamic>? todoData;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (todoData == null || todoData!.isEmpty || getIndex >= todoData!.length) {
      return Container();
    }

    final todoItem = todoData![getIndex];
    Color categoryColor = Colors.white;

    final getCategory = todoItem.category;

    switch (getCategory) {
      case 'Learn':
        categoryColor = Colors.green.shade500;
        break;
      case 'Work':
        categoryColor = Colors.blue.shade500;
        break;
      case 'General':
        categoryColor = Colors.orange.shade500;
        break;
    }

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(children: [
        Container(
          decoration: BoxDecoration(
            color: categoryColor,
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(12),
              bottomLeft: Radius.circular(12),
            ),
          ),
          width: 20,
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 3),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: IconButton(
                      iconSize: 25,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text('Confirm Deletion'),
                              content: const Text('Are you sure you want to delete this task?'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Cancel'),
                                ),
                                TextButton(
                                  onPressed: () {
                                    ref.read(serviceProvider).deleteTask(todoItem.docID);
                                    Navigator.of(context).pop();
                                  },
                                  child: const Text('Delete'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      icon: const Icon(CupertinoIcons.delete),
                    ),
                    title: Text(
                      todoItem.titleTask,
                      maxLines: 1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        decoration: todoItem.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                    ),
                    subtitle: Text(
                      todoItem.description,
                      maxLines: 1,
                      style: TextStyle(
                        decoration: todoItem.isDone ? TextDecoration.lineThrough : TextDecoration.none,
                      ),
                    ),
                    trailing: Transform.scale(
                      scale: 1.3,
                      child: Checkbox(
                        activeColor: Colors.blue.shade800,
                        shape: const CircleBorder(),
                        value: todoItem.isDone,
                        onChanged: (value) => ref
                            .read(serviceProvider)
                            .updateTask(todoItem.docID, value),
                      ),
                    ),
                  ),
                  Transform.translate(
                    offset: const Offset(0, -7),
                    child: Column(
                      children: [
                        Divider(
                          thickness: 1.5,
                          color: Colors.grey.shade200,
                        ),
                        Row(
                          children: [
                            Text("   Date: ${todoItem.dateTask}"),
                            const Gap(40),
                            Text("Due-time: ${todoItem.timeTask}"),
                          ],
                        )
                      ],
                    ),
                  )
                ]),
          ),
        ),
      ]),
    );
  }
}
