import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChatApp extends StatefulWidget {
  const ChatApp({super.key});

  @override
  State<ChatApp> createState() => _ChatAppState();
}

class _ChatAppState extends State<ChatApp> {
  var textcr = TextEditingController();
  List<String> data = [];

  sharedGet() async {
    var sh = await SharedPreferences.getInstance();
    setState(() {
      data = sh.getStringList("data") ?? [];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    sharedGet();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat App",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25)),
        backgroundColor: const Color.fromARGB(255, 10, 207, 181),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(data[index]),
                    tileColor: Colors.blue,
                    trailing: InkWell(
                        onTap: () {
                          setState(() {
                            showDialog(context: context, builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.white,
                                actions: [
                                  
                                ],
                              );
                            });
                            data.removeAt(index);
                            SharedPreferences.getInstance().then((sh) {
                              sh.setStringList("data", data);
                            });
                          });
                        },
                        child: const Icon(Icons.delete)),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textcr,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                suffixIcon: InkWell(
                    onTap: () async {
                      if (textcr.text.isNotEmpty) {
                        setState(() {
                          data.add(textcr.text);
                          textcr.text = "";
                        });
                        var sh = await SharedPreferences.getInstance();
                        sh.setStringList("data", data);
                      }
                    },
                    child: const Icon(Icons.send_rounded)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
