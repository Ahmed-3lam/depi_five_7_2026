import 'package:hive/hive.dart';

class HiveHelper {
  static const noteBox = "Note_Box";
  static const noteKey = "Note_Key";
  static List<String> myNotes = [];

  static Future<void> getNotes() async {
    await Future.delayed(Duration(seconds: 1));
    myNotes = await Hive.box(noteBox).get(noteKey);
  }

  static void addNote(String note) async {
    myNotes.add(note);
    await Hive.box(noteBox).put(noteKey, myNotes);
  }

  static void deleteNote(int index) async {
    myNotes.removeAt(index);
    await Hive.box(noteBox).put(noteKey, myNotes);
  }

  static void deleteAllNotes() async {
    myNotes.clear();
    await Hive.box(noteBox).put(noteKey, myNotes);
  }

  static void updateNote(int index, String text) async{
    myNotes[index] =text;
    await Hive.box(noteBox).put(noteKey, myNotes);

  }

  ///Requirment:
  ///(1) add note
  ///(2) delete note
  ///(3) update note
  ///(4) delete all notes
}
