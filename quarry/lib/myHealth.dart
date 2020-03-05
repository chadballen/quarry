import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyHealth extends StatefulWidget {
  final List<String> symptoms;
  MyHealth(this.symptoms);

  @override
  _MyHealthState createState() => _MyHealthState();
}

class _MyHealthState extends State<MyHealth> {
  final _formKey = GlobalKey<FormState>();
  final _dateController = TextEditingController();
  List<String> selectedChoices = [];
  DateTime selectedDate;
  _buildChoiceList() {
    List<Widget> choices = List();

    widget.symptoms.forEach((item) {
      choices.add(Container(
        padding: const EdgeInsets.all(2.0),
        child: ChoiceChip(
          label: Text(item),
          selected: selectedChoices.contains(item),
          onSelected: (selected) {
            setState(() {
              selectedChoices.contains(item)
                  ? selectedChoices.remove(item)
                  : selectedChoices.add(item);
            });
          },
        ),
      ));
    });

    return choices;
  }

  void initState() {
    _dateController.addListener(() {
      final text = selectedDate.toString().toLowerCase();
      _dateController.value = _dateController.value.copyWith(
        text: text,
        selection:
            TextSelection(baseOffset: text.length, extentOffset: text.length),
        composing: TextRange.empty,
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final dateText = selectedDate.toString();
    return Container(
        child: Center(
            child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    TextFormField(
                      decoration: const InputDecoration(hintText: 'Date'),
                      onTap: (() async {
                        final DateTime date = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2020),
                            lastDate: DateTime.now());
                        setState(() {
                          selectedDate:
                          date;
                        });
                      }),
                      controller: _dateController,
                    ),
                    (Wrap(
                      children: _buildChoiceList(),
                    )),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Center(
                        child: RaisedButton(
                          onPressed: () {
                            if (_formKey.currentState.validate()) {
                              print('Validate Field');
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ),
                    )
                  ],
                ))));
  }
}
