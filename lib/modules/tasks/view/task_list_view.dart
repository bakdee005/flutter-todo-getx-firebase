import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controller/task_controller.dart';
import '../../auth/controller/auth_controller.dart';

// ignore: use_key_in_widget_constructors
class TaskListView extends StatelessWidget {
  final TaskController controller = Get.put(TaskController());
  final auth = Get.find<AuthController>();

  @override
  Widget build(BuildContext context) {
    controller.fetchTasks();

    return Scaffold(
      appBar: AppBar(
        title: const Text("My Tasks"),
        backgroundColor: Colors.green,
        actions: [
          /// Logout icon 
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              /// logout confirmation dialog
              Get.defaultDialog(
                title: "",
                titleStyle:const TextStyle(fontSize: 1),
                radius: 10,
                content: Column(
                  children: [
                    const Icon(
                      Icons.logout,
                      size: 50,
                      color: Colors.red,
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Logout",
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Are you sure you want to logout?",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.black,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      children: [
                        Expanded(
                          child: OutlinedButton(
                            onPressed: () {
                              Get.back();
                            },
                            child: const Text("Cancel", style: TextStyle(fontSize: 16, color: Colors.black),),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            onPressed: () {
                              auth.logout();

                              Get.back();
                            },
                            child: const Text("Logout",style: TextStyle(fontSize: 16,),),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              );
            },
          )
        ],
      ),
      body: Obx(() {
        if (controller.loading.value) {
          return const Center(
              child: CircularProgressIndicator(
            backgroundColor: Colors.green,
            color: Colors.white12,
          ));
        }

        return controller.tasks.isEmpty ? 
          const Center(
             child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
               children: [
                Icon(Icons.hourglass_empty_rounded, color: Colors.grey,size: 45,),
                 Text("No task added",style:  TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),),
               ],
             ),
           )
          : ListView.builder(
          itemCount: controller.tasks.length,
          itemBuilder: (context, index) {
            final task = controller.tasks[index];
            int currentIndex = index + 1;

            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(16)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "${currentIndex.toString()}.",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              decoration: task.completed
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Text(
                            task.title,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              decoration: task.completed
                                  ? TextDecoration.lineThrough
                                  : null,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                              onTap: () {
                                TextEditingController text =
                                    TextEditingController(text: task.title);
                                TextEditingController hoursControllertext =
                                    TextEditingController(text: task.hours);

                                Get.bottomSheet(
                                  Container(
                                    padding: const EdgeInsets.all(20),
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.vertical(
                                        top: Radius.circular(20),
                                      ),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "Edit Task",
                                          style: TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        TextField(
                                          controller: text,
                                          decoration: const InputDecoration(
                                            labelText: "Task Name",
                                            border: OutlineInputBorder(),
                                            prefixIcon: Icon(Icons.task),
                                          ),
                                        ),
                                        const SizedBox(height: 15),
                                        TextField(
                                          controller: hoursControllertext,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            labelText: "Hours Required",
                                            border: OutlineInputBorder(),
                                            prefixIcon: Icon(Icons.timer),
                                          ),
                                        ),
                                        const SizedBox(height: 20),
                                        SizedBox(
                                          width: double.infinity,
                                          height: 50,
                                          child: ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: Colors.green,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            onPressed: () {
                                              controller.editTask(
                                                  task,
                                                  text.text,
                                                  hoursControllertext.text);
                                              Get.back();
                                            },
                                            child: const Text(
                                              "Update",
                                              style: TextStyle(fontSize: 16),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    ),
                                  ),
                                  isScrollControlled: true,
                                );
                              },
                              child: const Icon(
                                Icons.edit,
                                color: Colors.black,
                              )),
                          const SizedBox(
                            width: 5,
                          ),
                          InkWell(
                              onTap: () {
                                controller.deleteTask(task.id!);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: Colors.red,
                              )),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            " Timing : ${task.hours}",
                            style: const TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const Spacer(),
                          const Text(
                            "Completed : ",
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Checkbox(
                            activeColor: Colors.green,
                            // checkColor: Colors.green,
                            value: task.completed,
                            onChanged: (_) => controller.toggleTask(task),
                          ),
                        ],
                      ),
                    ],
                  )),
            );
          },
        );
      }),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton.extended(
        backgroundColor: Colors.green,
        icon: const Icon(Icons.add),
        label: const Text(
          "Add Task",
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
        onPressed: () {
          TextEditingController text = TextEditingController();
          TextEditingController hoursControllertext = TextEditingController();

          Get.bottomSheet(
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    "Add New Task",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: text,
                    decoration: const InputDecoration(
                      labelText: "Task Name",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.task),
                    ),
                  ),
                  const SizedBox(height: 15),
                  TextField(
                    controller: hoursControllertext,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      labelText: "Hours Required",
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.timer),
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.green,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        controller.addTask(text.text, hoursControllertext.text);
                        Get.back();
                      },
                      child: const Text(
                        "Add Task",
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            isScrollControlled: true,
          );
          // Get.defaultDialog(
          //   title: "Add Task",
          //   content: Column(
          //     children: [
          //       TextField(controller: text),
          //       TextField(controller: hoursControllertext),
          //     ],
          //   ),
          //   confirm: ElevatedButton(
          //     onPressed: () {
          //       controller.addTask(text.text, hoursControllertext.text);
          //       Get.back();
          //     },
          //     child: Text("Add"),
          //   ),
          // );
        },
      ),
    );
  }
}
