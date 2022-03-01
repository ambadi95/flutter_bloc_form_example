import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:form_bloc_pattern/features/eod_form/form_event.dart';
import 'package:form_bloc_pattern/features/eod_form/form_repository.dart';
import 'package:form_bloc_pattern/features/eod_form/form_state.dart';
import 'package:form_bloc_pattern/features/eod_form/form_submission_status.dart';

class EodForm extends Bloc<FormEvent, FormState>{
  final FormRepo formRepo;
  EodForm ({required this.formRepo}) : super(FormState());

  @override
  Stream<FormState> mapEventToState(FormEvent event) async*{
   if(event is FormDateEventChanged){
     yield state.copyWith(date: event.date);
   }else if (event is FormSubmitted){
     yield state.copyWith(formStatus: FormSubmitting());

     try {
       await formRepo.submitEod();
       yield state.copyWith(formStatus: FormSubmissionSuccess());
     } catch (e){
       yield state.copyWith(formStatus: FormSubmissionFailed());
     }

   }
  }
}