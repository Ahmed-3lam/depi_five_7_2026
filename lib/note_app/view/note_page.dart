import 'package:depi_five/core/helpers/hive_helper.dart';
import 'package:flutter/material.dart';

class NotePage extends StatefulWidget {
  const NotePage({super.key});

  @override
  State<NotePage> createState() => _NotePageState();
}

class _NotePageState extends State<NotePage> {
  final _controller = TextEditingController();
  final _key = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  void didChangeDependencies() async {
    _isLoading = true;
    await HiveHelper.getNotes();
    _isLoading = false;
    setState(() {});
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            barrierDismissible: false, // User must tap a button to dismiss
            builder: (BuildContext context) {
              return Form(
                key: _key,
                child: AlertDialog(
                  title: const Text('Add Note'),
                  content: TextFormField(
                    controller: _controller,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "You should add any content";
                      }
                    },
                  ),

                  actions: [
                    TextButton(
                      child: const Text('Cancel'),
                      onPressed: () {
                        // Get.back();
                        Navigator.pop(context);
                      },
                    ),
                    TextButton(
                      child: const Text('Add'),
                      onPressed: () {
                        _key.currentState!.validate();
                        if (_controller.text.isNotEmpty) {
                          HiveHelper.addNote(_controller.text);
                          setState(() {
                            Navigator.pop(context);
                            _controller.text = "";
                          });
                        }
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
        backgroundColor: Colors.blue,
        child: Icon(Icons.add, color: Colors.white),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text("Note APP", style: TextStyle(color: Colors.white)),
        centerTitle: false,
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextButton(
              onPressed: () {
                HiveHelper.deleteAllNotes();
                setState(() {});
              },
              child: Text("Clear All", style: TextStyle(color: Colors.white)),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: HiveHelper.myNotes.length,
              itemBuilder: (context, index) => Stack(
                children: [
                  InkWell(
                    onTap: () {
                      _controller.text = HiveHelper.myNotes[index];
                      showDialog(
                        context: context,
                        barrierDismissible:
                            false, // User must tap a button to dismiss
                        builder: (BuildContext context) {
                          return Form(
                            key: _key,
                            child: AlertDialog(
                              title: const Text('Update Note'),
                              content: TextFormField(
                                controller: _controller,
                                validator: (value) {
                                  if (value!.isEmpty) {
                                    return "You should add any content";
                                  }
                                },
                              ),

                              actions: [
                                TextButton(
                                  child: const Text('Cancel'),
                                  onPressed: () {
                                    // Get.back();
                                    Navigator.pop(context);
                                  },
                                ),
                                TextButton(
                                  child: const Text('Update'),
                                  onPressed: () {
                                    _key.currentState!.validate();
                                    if (_controller.text.isNotEmpty) {
                                      HiveHelper.updateNote(
                                        index,
                                        _controller.text,
                                      );
                                      setState(() {
                                        Navigator.pop(context);
                                        _controller.text = "";
                                      });
                                    }
                                  },
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                    child: Container(
                      margin: EdgeInsets.all(12),
                      width: double.infinity,
                      height: 200,
                      decoration: BoxDecoration(
                        color: index == 0
                            ? Colors.amber.withOpacity(.2)
                            : index % 2 == 0
                            ? Colors.green.withOpacity(.2)
                            : Colors.deepOrange.withOpacity(.2),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(child: Text(HiveHelper.myNotes[index])),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      onPressed: () {
                        HiveHelper.deleteNote(index);
                        setState(() {});
                      },
                      icon: Icon(Icons.delete, color: Colors.red),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}



///Requirment:
///(1) add note
///(2) delete note
///(3) update note
///(4) delete all notes