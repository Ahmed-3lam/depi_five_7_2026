import 'package:bloc/bloc.dart';
import 'package:depi_five/core/helpers/hive_helper.dart';
import 'package:meta/meta.dart';

part 'note_state.dart';

class NoteCubit extends Cubit<NoteState> {
  NoteCubit() : super(NoteInitial());

  void getNotes() async {
    emit(NoteLoadingState());
    await HiveHelper.getNotes();
    if (HiveHelper.myNotes.isEmpty) {
      emit(NoteEmptyState());
    } else {
      emit(NoteSuccessState());
    }
  }

  void addNote(String text) {
    HiveHelper.addNote(text);
    emit(NoteAddedState());
  }

  void clearAllNotes() {
    HiveHelper.deleteAllNotes();
    emit(NoteClearAllState());
  }

  void updateNote(int index, String text) {
    HiveHelper.updateNote(index, text);
    emit(NoteAddedState());
  }

  void deleteNote(int index) {
    HiveHelper.deleteNote(index);
    emit(NoteDeleteNoteState());
  }
}
