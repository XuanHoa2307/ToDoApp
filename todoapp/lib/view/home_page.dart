import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: depend_on_referenced_packages
import 'package:gap/gap.dart';
import 'package:intl/intl.dart';
import 'package:todoapp/common/show_model.dart';
import 'package:todoapp/provider/service_provider.dart';
import 'package:todoapp/widget/card_todo_widget.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  String searchQuery = '';
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();
  String selectedFilter = 'All days';

  @override
  Widget build(BuildContext context) {
    final todoData = ref.watch(fetchStreamProvider);

    return Scaffold(
      backgroundColor: Colors.grey.shade200,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        title: isSearching
            ? TextField(
                controller: searchController,
                autofocus: true,
                onChanged: (value) {
                  setState(() {
                    searchQuery = value;
                  });
                },
                decoration: InputDecoration(
                  hintText: 'Search tasks...',
                  border: InputBorder.none,
                  hintStyle: TextStyle(color: Colors.grey.shade600),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 16),
              )
              :ListTile(
                leading: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6),
                  child: CircleAvatar(
                    backgroundColor: Colors.amber.shade200,
                    radius: 25,
                    child: ClipOval(
                      child: Image.asset(
                        'assets/profile.png',
                        fit: BoxFit.cover,
                        width: 35,
                        height: 35,
                      ),
                    ),
                  ),
                ),
                title: Text(
                  'Hi, I\'m',
                  style: TextStyle(fontSize: 12, color: Colors.grey.shade400),
                ),
                subtitle: const Text(
                  'Suhao',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),
                ),
              ),
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                if (isSearching)
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = false;
                        searchQuery = '';
                        searchController.clear();
                      });
                    },
                    icon: const Icon(CupertinoIcons.clear),
                  )
                else
                  IconButton(
                    onPressed: () {
                      setState(() {
                        isSearching = true;
                      });
                    },
                    icon: const Icon(CupertinoIcons.search),
                  ),
                const SizedBox(width: 5),
                IconButton(onPressed: () {}, icon: const Icon(CupertinoIcons.bell))
              ],
            ),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            const Gap(20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "My Task List",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Time New Roman',
                        color: Color.fromARGB(255, 15, 0, 126),
                      ),
                    ),
                    Text(
                      DateFormat('EEEE, d MMMM').format(DateTime.now()),
                      style: const TextStyle(color: Colors.black, fontSize: 17),
                    )
                  ],
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color.fromARGB(255, 164, 184, 255),
                    foregroundColor: const Color.fromARGB(255, 0, 2, 125),
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  onPressed: () => showModalBottomSheet(
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    context: context,
                    builder: (context) => const AddNewTaskModel(),
                  ),
                  child: const Text('+ New Task'),
                )
              ],
            ),
            const Gap(15),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 190, 223, 255),//const Color.fromARGB(255, 164, 184, 255),
                    borderRadius: BorderRadius.circular(50),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 11),
                  child: DropdownButton<String>(
                    value: selectedFilter,
                    dropdownColor: Colors.white,
                    style: TextStyle(
                      color: Colors.blue.shade900,
                      fontSize: 14,
                    ),
                    underline: Container(),
                    items: const [
                      DropdownMenuItem(value: 'All days', child: Text('All days', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),)),
                      DropdownMenuItem(value: 'Today', child: Text('Today',style: TextStyle(fontWeight: FontWeight.bold, color: Color.fromARGB(255, 255, 0, 47)))),
                      DropdownMenuItem(value: 'Upcoming', child: Text('Upcoming',style: TextStyle(fontWeight: FontWeight.bold))),
                    ],
                    onChanged: (value) {
                      setState(() {
                        selectedFilter = value!;
                      });
                    },
                    icon: Icon(Icons.arrow_drop_down, color: Colors.blue.shade900),
                  ),
                ),
              ],
            ),


            const Gap(30),
            Expanded(
            child: ListView.builder(
              itemCount: todoData.value
                  ?.where((todo) {
                    DateTime? todoDate;
                    try {
                      todoDate = DateFormat('MM/dd/yyyy').parse(todo.dateTask);
                    } catch (e) {
                      return false;
                    }
                    if (selectedFilter == 'Today') {
                      return DateFormat('yyyy-MM-dd').format(DateTime.now()) ==
                          DateFormat('yyyy-MM-dd').format(todoDate);
                    } else if (selectedFilter == 'Upcoming') {
                      final tomorrow = DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day + 1,
                      );
                      return todoDate.isAtSameMomentAs(tomorrow) || todoDate.isAfter(tomorrow);
                    }
                    return true;
                  })
                  .where((todo) => todo.titleTask
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()))
                  .length ?? 0,
                itemBuilder: (BuildContext context, int index) {
                final filteredData = todoData.value
                  ?.where((todo) {
                    DateTime? todoDate;
                    try {
                      todoDate = DateFormat('MM/dd/yyyy').parse(todo.dateTask);
                    } catch (e) {
                      return false;
                    }
                    if (selectedFilter == 'Today') {
                      return DateFormat('yyyy-MM-dd').format(DateTime.now()) ==
                          DateFormat('yyyy-MM-dd').format(todoDate);
                    } else if (selectedFilter == 'Upcoming') {
                      final tomorrow = DateTime(
                        DateTime.now().year,
                        DateTime.now().month,
                        DateTime.now().day + 1,
                      );
                      return todoDate.isAtSameMomentAs(tomorrow) || todoDate.isAfter(tomorrow);
                    }
                    return true;
                  })
                  .where((todo) => todo.titleTask
                      .toLowerCase()
                      .contains(searchQuery.toLowerCase()))
                  .toList();
                return CardToDoListWidget(getIndex: index, todoData: filteredData);
              },
            ),
          ),

          ],
        ),
      ),
    );
  }
}
