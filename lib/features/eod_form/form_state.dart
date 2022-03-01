import 'package:form_bloc_pattern/features/eod_form/form_submission_status.dart';

class FormState {
  final String? date;
  final FormSubmissionStatus? formStatus;

  FormState({this.date = '', this.formStatus = const InitialFormStatus()});

  FormState copyWith({String? date, FormSubmissionStatus? formStatus}) {
    return FormState(date: date ?? this.date,
      formStatus: formStatus ?? formStatus,
    );
  }
}
