import 'package:bloc/bloc.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState("en")) {
    on<LanguageEvent>((event, emit) {
      emit(LanguageState(event.lang == "en" ? "ar" : "en"));
    });
  }
}
