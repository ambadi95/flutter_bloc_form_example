abstract class FormEvent{}

class FormDateEventChanged extends FormEvent {
  final String? date;
  FormDateEventChanged({this.date});
}

class FormSubmitted extends FormEvent {}