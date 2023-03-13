import 'package:flutter/material.dart';


class InputPage extends StatefulWidget {
  const InputPage();

  @override
  State<InputPage> createState() => _InputPageState();
}

class _InputPageState extends State<InputPage> {


  String _name = "";
  String _email = "";
  String _date = "";
  String _selectedOption = 'Flight';
  List<String> _powers = ['Flight', 'X-Ray'];

  TextEditingController _inputFieldDateController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Text inputs'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
        children: [
          _createInput(),
          Divider(),
          _createEmail(),
          Divider(),
          _createPwd(),
          Divider(),
          _createDate(),
          Divider(),
          _createDropdown(),
          Divider(),
          _createPerson()
        ],
      ),
    );
  }

  Widget _createInput() {

  return TextField(
    textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0)
      ),
      counter: Text('chars ${_name.length}'),
      hintText: 'Name',
      labelText: 'Name',
      helperText: 'Just your name',
      suffixIcon: Icon(Icons.accessibility),
      icon: Icon (Icons.account_circle)
    ),
    onChanged: (value) => setState(() { _name = value;}),
  );

 }

  Widget _createPerson() {
    return ListTile(
      title: Text('Name is: $_name'),
      subtitle: Text('Email: $_email'),
      trailing: Text(_selectedOption),
    );
  }

  Widget _createEmail() {

    return TextField(
      keyboardType: TextInputType.emailAddress,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        hintText: 'Email',
        labelText: 'Email',
        suffixIcon: Icon(Icons.alternate_email),
        icon: Icon (Icons.email)
      ),
      onChanged: (value) => setState(() { _email = value; }),
    );

    }

  Widget _createPwd() {
    return TextField(
      obscureText: true,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        hintText: 'Password',
        labelText: 'Password',
        suffixIcon: Icon(Icons.lock_open),
        icon: Icon (Icons.lock)
      ),
      onChanged: (value) => setState(() { _email = value; }),
    );
  }

  Widget _createDate() {

    return TextField(
      enableInteractiveSelection: false,
      controller: _inputFieldDateController,
      decoration: InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0)
        ),
        hintText: 'Birthdate',
        labelText: 'Birthdate',
        suffixIcon: Icon(Icons.perm_contact_calendar),
        icon: Icon (Icons.calendar_today)
      ),
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
        _selectDate( context );
      },
    );

  }

  _selectDate(BuildContext context) async {

    DateTime? picked = await showDatePicker(
        context: context, 
        initialDate: new DateTime.now(), 
        firstDate: new DateTime(2018), 
        lastDate: new DateTime(2025),
        locale: Locale('es', 'ES')
      );

    if (picked != null) {
      setState(() {
        _date = picked.toString();
        _inputFieldDateController.text = _date;
      });
    }  

  }

  List<DropdownMenuItem<String>> getDropdownOptions() {
    List<DropdownMenuItem<String>> myList = [];
    _powers.forEach(( power ) {
      myList.add( DropdownMenuItem(
        child: Text( power ),
        value: power
      ));
    });
    return myList;
  }

  Widget _createDropdown() {

    return Row(
      children: [
        Icon(Icons.select_all),
        SizedBox(width: 30.0),
        Expanded(
          child: DropdownButton(
            value: _selectedOption,
            items: getDropdownOptions(),
            onChanged: ( opt ) {
              setState(() {
                _selectedOption = opt as String;
              });
            },
          ),
        )
      ],
    );
  }
}