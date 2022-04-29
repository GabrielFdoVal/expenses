import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionForm extends StatefulWidget {
  final void Function(String, double, DateTime) onSubmit;

  TransactionForm(this.onSubmit);

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

class _TransactionFormState extends State<TransactionForm> {
  final _titleControler = TextEditingController();
  final _valueControler = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _submitForm() {
    final title = _titleControler.text;
    final value = double.tryParse(_valueControler.text) ?? 0.0;

    if (title.isEmpty || value < 0) {
      return;
    }

    widget.onSubmit(title, value, _selectedDate);
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return null;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Padding(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: 10 + MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: <Widget>[
              TextField(
                controller: _titleControler,
                decoration: InputDecoration(
                  label: Text("Título"),
                ),
                onSubmitted: (_) => _submitForm(),
              ),
              TextField(
                controller: _valueControler,
                decoration: InputDecoration(
                  label: Text("Valor (R\$)"),
                ),
                keyboardType: TextInputType.numberWithOptions(
                  decimal: true,
                ),
                onSubmitted: (_) => _submitForm(),
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? "Nenhuma date selecionada"
                          : "Data selecionada: ${DateFormat('d/MM/y').format(
                              _selectedDate,
                            )}",
                    ),
                  ),
                  TextButton(
                    child: Text(
                      "Nova transação",
                      style: TextStyle(
                        color: Colors.purple,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    onPressed: _showDatePicker,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: <Widget>[
                  ElevatedButton(
                    child: Text(
                      "Nova transação",
                      style: Theme.of(context).textTheme.button,
                    ),
                    onPressed: _submitForm,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
