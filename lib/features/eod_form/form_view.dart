import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:form_bloc_pattern/features/eod_form/form_bloc_logic.dart';
import 'package:form_bloc_pattern/features/eod_form/form_repository.dart';
import 'package:form_bloc_pattern/features/eod_form/form_state.dart' as b;
import 'form_event.dart';

class FormScreen extends StatefulWidget {
  const FormScreen({Key? key}) : super(key: key);

  @override
  _FormScreenState createState() => _FormScreenState();
}

class _FormScreenState extends State<FormScreen> {
  TextEditingController taskDate =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage EOD'),
      ),
      body: BlocProvider(create: (context)=> EodForm(formRepo: context.read<FormRepo>()),child:
      SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SizedBox(
            height: height - 120,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                textWithLabel('Project Title', 'CRAYON_CU_NEOM_5665'),
                textWithLabel('Sprint Title', 'FEB-2022-MAR-2022'),
                textWithLabel('Task Title', 'DATE_TASK'),
                textWithLabel('Allocated Hours', '8'),
                const SizedBox(
                  height: 20,
                ),
                const Divider(),
                const SizedBox(
                  height: 20,
                ),
                const Text('EOD Task Details', style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),),
                const SizedBox(
                  height: 20,
                ),
                textWithTextFieldDate('Task Date' , 'Task Date' , taskDate),
                textWithTextField('Hours Spend' , 'Hours Spend' , taskDate),
                textWithTextField('% Completion' , 'Overall Task Completion %' , taskDate),
                textWithTextField('Comments' , 'Enter Comments Here...' , taskDate),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    button('Cancel', Colors.white, Colors.black.withOpacity(0.5)),
                    const SizedBox(
                      width: 10,
                    ),
                    button('Submit', Colors.blue, Colors.white),
                    const SizedBox(
                      width: 10,
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
      ),
    );
  }

  Widget textWithLabel(String? title, String label){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('$title : ',style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold
          ),),
          Text(label,style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500
          ),),
        ],
      ),
    );
  }

  Widget textWithTextField(String? title, String label, TextEditingController controller){
    return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text('$title : ',style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold
            ),),
          ),
         Padding(
           padding: const EdgeInsets.only(right: 10),
           child: SizedBox(
             width: 220,
             child: TextField(
               controller: controller,
               decoration:  InputDecoration(
                 border: const OutlineInputBorder(),
                 hintText: label,
               ),
             ),
           ),
         )
        ],
      ),
    );
  }

  Widget textWithTextFieldDate(String? title, String label, TextEditingController controller){
    return BlocBuilder<EodForm, b.FormState>(builder: (BuildContext context, b.FormState state) {
      return Padding(
        padding: const EdgeInsets.only(top: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text('$title : ', style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
              ),),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: SizedBox(
                width: 220,
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: TextFormField(
                    controller: controller,
                    validator: (value) => null,
                    onChanged:  (value)=> context.read<EodForm>().add(FormDateEventChanged(date: value)),
                    decoration: InputDecoration(
                        border: const OutlineInputBorder(),
                        hintText: label,
                        suffixIcon: GestureDetector(
                            onTap: () {
                              DatePicker.showDatePicker(context,
                                  showTitleActions: true,
                                  minTime: DateTime(2018, 3, 5),
                                  maxTime: DateTime(2025, 6, 7),
                                  onChanged: (date) {},
                                  onConfirm: (date) {
                                    setState(() {
                                      taskDate.text =
                                      date.toString().split(' ')[0];
                                    });
                                  },
                                  currentTime: DateTime.now(),
                                  locale: LocaleType.en);
                            },
                            child: const Icon(Icons.calendar_today_outlined))
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      );
    }
    );
  }

  Widget button(String label, Color color, Color fontColor){
    return Container(
      height: 40,
      width: 70,
      decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey ,width: 1)
      ),
      child: Center(
        child: Text(label, style: TextStyle(
            fontSize: 14,
            color: fontColor
        ),),
      ),
    );
  }
}
