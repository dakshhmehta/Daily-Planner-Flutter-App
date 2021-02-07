import 'package:daily_planner/models/task.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Task> tasks = [
    Task("My first task"),
    Task(
        "My second task long title may go here which may get auto wrapped depending on the length of the width of phone.")
  ];

  TextEditingController _taskNameController = TextEditingController();

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
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              color: Colors.green[400],
                                              onPressed: () => {
                                                    changeStatus(
                                                        index, "completed"),
                                                    Navigator.pop(ctx)
                                                  }),
                                          RaisedButton(
                                              child: Text("Mark for Later",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              color: Colors.blue[400],
                                              onPressed: () => {
                                                    changeStatus(
                                                        index, "later"),
                                                    Navigator.pop(ctx)
                                                  }),
                                          RaisedButton(
                                              child: Text("Cancel",
                                                  style: TextStyle(
                                                      color: Colors.white)),
                                              color: Colors.red[400],
                                              onPressed: () => {
                                                    changeStatus(
                                                        index, "cancelled"),
                                                    Navigator.pop(ctx)
                                                  }),
                                          RaisedButton(
                                              child: Text("Close"),
                                              onPressed: () =>
                                                  {Navigator.pop(ctx)})
                                        ],
                                      ),
                                      height: 250,
                                    );
                                  },
                                  context: ctx)
                              : changeStatus(index, 'incomplete'),
                          // leading: Text("${index + 1}."),
                          title: Text("${tasks[index].title}"),
                          leading: tasks[index].getIcon()));
                },
              ),
            )
          ],
        ),
      ),
    );
  }

  changeStatus(int index, String status) {
    print("$index completed");
    tasks[index].changeStatus(status);
    setState(() {});
  }

  addTask(BuildContext ctx) {
    if (_taskNameController.text.isNotEmpty) {
      print("in");
      tasks.add(Task(_taskNameController.text));
      _taskNameController.text = null;

      Navigator.pop(ctx);
      setState(() {});

      return true;
    }
    print("out");

    return false;
  }
}
