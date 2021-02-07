import 'package:daily_planner/models/task.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = new List();
  TextEditingController _taskNameController = TextEditingController();

  initState() {
    super.initState();
    refreshTasks();
  }

  refreshTasks() {
    var that = this;
    Task.getAll().then((data) => {tasks = data, that.setState(() => {})});
  }

  @override
  Widget build(BuildContext rootContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Daily Planner"),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            color: Colors.white,
            onPressed: () => {},
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => showDialog(
              context: rootContext,
              builder: (ctx) {
                return AlertDialog(
                  title: Text("Add Task"),
                  content: TextField(
                    controller: _taskNameController,
                  ),
                  actions: [
                    TextButton(
                      child: Text("Add"),
                      onPressed: () => addTask(rootContext),
                    )
                  ],
                );
              }),
          child: Icon(Icons.add)),
      body: Container(
        color: Colors.grey[100],
        padding: EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Tasks:",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            Container(
              margin: EdgeInsets.only(top: 5),
              height: MediaQuery.of(rootContext).size.height * 0.5,
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (BuildContext ctx, int index) {
                  return Card(
                      child: ListTile(
                    onTap: () => tasks[index].status == 'incomplete'
                        ? showBottomSheet(
                            builder: (ctx) {
                              return Container(
                                margin: EdgeInsets.only(top: 50),
                                padding: EdgeInsetsDirectional.only(
                                    start: 50, end: 50),
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    RaisedButton(
                                        child: Text("Mark Completed",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: Colors.green[400],
                                        onPressed: () => {
                                              changeStatus(index, "completed"),
                                              Navigator.pop(ctx)
                                            }),
                                    RaisedButton(
                                        child: Text("Mark for Later",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: Colors.blue[400],
                                        onPressed: () => {
                                              changeStatus(index, "later"),
                                              Navigator.pop(ctx)
                                            }),
                                    RaisedButton(
                                        child: Text("Cancel",
                                            style:
                                                TextStyle(color: Colors.white)),
                                        color: Colors.red[400],
                                        onPressed: () => {
                                              changeStatus(index, "cancelled"),
                                              Navigator.pop(ctx)
                                            }),
                                    RaisedButton(
                                        child: Text("Close"),
                                        onPressed: () => {Navigator.pop(ctx)})
                                  ],
                                ),
                                height: 250,
                              );
                            },
                            context: ctx)
                        : changeStatus(index, 'incomplete'),
                    // leading: Text("${index + 1}."),
                    title: Text("${tasks[index].title}"),
                    subtitle: Text("ID: ${tasks[index].id}"),
                    leading: tasks[index].getIcon(),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete,
                        color: Colors.red[900],
                      ),
                      onPressed: () => deleteTask(index),
                    ),
                  ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  changeStatus(int index, String status) {
    tasks[index].changeStatus(status);
    setState(() {});
  }

  addTask(BuildContext ctx) {
    if (_taskNameController.text.isNotEmpty) {
      // print("in");
      Task t = Task(title: _taskNameController.text);
      t.save();

      tasks.add(t);
      refreshTasks();
      Navigator.pop(ctx);
      _taskNameController.clear();

      return true;
    }
    // print("out");

    return false;
  }

  deleteTask(int index) {
    tasks[index].delete();
    refreshTasks();
  }
}
