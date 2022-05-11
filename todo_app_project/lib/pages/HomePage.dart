// ignore_for_file: deprecated_member_use

import 'package:firebase_app_web/Service/Auth_Service.dart';
import 'package:firebase_app_web/pages/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'dart:convert';
import 'detailsPage.dart';

List<Map> allTodos = [];
List<Map> listToShow = [];

class HomePage extends StatefulWidget {
  // Declare a field that holds the Todo.
  final userEmail;
  HomePage({Key key, String user, this.userEmail}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState(userEmail);
}

class _HomePageState extends State<HomePage> {
  var userEmail;
  _HomePageState(this.userEmail);

  void getData() async {
    http.Response response =
        await http.get(Uri.parse('https://gorest.co.in/public/v2/todos'));
    if (response.statusCode == 200) {
      var data = response.body;
      var todos = jsonDecode(data);
      for (int i = 0; i < 20; i++) {
        var formattedDate =
            DateFormat("yyyy-MM-dd", "en_US").parse(todos[i]['due_on']);
        todos[i]['due_on'] = formattedDate.toString();
        var tasks = todos[i];

        setState(() {
          allTodos.add(tasks);
          listToShow = allTodos;
        });
      }
    }
  }

  AuthClass authClass = AuthClass();
  @override
  void initState() {
    super.initState();
    getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dahboard'),
        backgroundColor: Color.fromARGB(255, 40, 156, 16),
        actions: [
          Center(
            child: Text(
              'Logout',
              style: TextStyle(fontSize: 17),
            ),
          ),
          IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                authClass.signOut();
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (builder) => SignInPage()),
                    (route) => true);
              }),
        ],
      ),
      drawer: new Drawer(
        child: ListView(
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: new Text(
                "Username",
                style:
                    new TextStyle(fontWeight: FontWeight.bold, fontSize: 17.0),
              ),
              accountEmail: new Text(userEmail),
              currentAccountPicture: CircleAvatar(
                backgroundColor: Colors.blue,
              ),
              decoration: new BoxDecoration(color: Colors.blueGrey),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('Details'),
            ),
          ],
        ),
      ),
      body: Container(
        width: double.infinity,
        child: Row(
          children: [
            ///Container for Content
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "ToDos",
                      style: TextStyle(
                          fontSize: 30,
                          height: 1.2,
                          letterSpacing: 1,
                          fontWeight: FontWeight.w900,
                          color: Colors.black26),
                    ),

                    ///For spacing
                    SizedBox(
                      height: 4,
                    ),

                    Row(
                      children: [
                        ///Text

                        Spacer(),

                        IconButton(
                          icon: Icon(Icons.edit),
                          onPressed: () {},
                        )
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                "Total Todos: " + allTodos.length.toString(),
                                style: TextStyle(
                                    fontWeight: FontWeight.w400, fontSize: 17),
                              ),
                            ]),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),

                    ///List of all the task
                    allTodos != []
                        ? Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return _listItems(index);
                                },
                                separatorBuilder: (context, index) => Divider(
                                      height: 16,
                                      color: Colors.transparent,
                                    ),
                                itemCount: listToShow.length),
                          )
                        : CircularProgressIndicator,

                    ///For spacing
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _listItems(index) {
    return InkWell(
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey[100]),
            color: listToShow[index]['status'] == 'completed'
                ? Color.fromARGB(255, 54, 43, 43)
                : Colors.transparent,
            borderRadius: BorderRadius.all(Radius.circular(5))),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ///Show completed check
            ///Task Title
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    listToShow[index]['title'],
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: listToShow[index]['status'] == 'completed'
                            ? Colors.white
                            : Colors.grey[800]),
                  ),
                ),

                ///For Space

                SizedBox(
                  width: 4,
                ),
              ],
            ),

            ///For Space
            SizedBox(
              height: 8,
            ),

            ///Task Detail
            Row(
              children: [
                Text(
                  listToShow[index]['due_on'],
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 12,
                      color: listToShow[index]['status'] == 'completed'
                          ? Colors.white70
                          : Colors.grey[500]),
                ),
                Spacer(),
                listToShow[index]['status'] == 'completed'
                    ? Text(
                        "COMPLETED",
                        style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 12,
                            color: Colors.white),
                      )
                    : Text(
                        listToShow[index]['status'].toUpperCase(),
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: listToShow[index]['status'] == 'completed'
                                ? Colors.white70
                                : Colors.grey[700]),
                      ),
              ],
            )
          ],
        ),
      ),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => (DetailsPage(
                      todo: listToShow[index],
                    ))));
      },
    );
  }
}
