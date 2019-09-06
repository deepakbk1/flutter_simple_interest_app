import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Simple Interest Claculator",
      home: SIForm(),
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.indigo,
          accentColor: Colors.indigoAccent,
          errorColor: Colors.amber),

    );
  }
}

class SIForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SIFormState();
  }
}

class _SIFormState extends State<SIForm> {
  var _currencies = ['Rupee', 'Doller', 'Pounds'];
  var _currentItemSelected = '';
  var _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _currentItemSelected = _currencies[0];
  }

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  String displayResult = '';

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme
        .of(context)
        .textTheme
        .title;
    // TODO: implement build
    return Scaffold(
      // resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text("Simple Interest Claculator"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          children: <Widget>[
            getImageAsset(),
            Padding(
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  style: textStyle,
                  controller: principalController,
                  validator: (String value) {
                    if (value.isEmpty) {
                      // ignore: missing_return
                      return 'Please enter principal amount';
                    }
                  },
                  decoration: InputDecoration(
                      labelText: "Principal",
                      hintText: "Enter Principal eg 1200",
                      labelStyle: textStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      hoverColor: Colors.white),
                ),
                padding: EdgeInsets.all(5.0)),
            Padding(
              child: TextFormField(
                keyboardType: TextInputType.number,
                style: textStyle,
                controller: roiController,
                validator: (String value) {
                  if (value.isEmpty) {
                    // ignore: missing_return
                    return 'Please enter rate of interest';
                  }
                },
                decoration: InputDecoration(
                    labelText: "Rate of  Intrest",
                    hintText: "In percent",
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0))),
              ),
              padding: EdgeInsets.all(5.0),
            ),
            Padding(
              child: Row(
                children: <Widget>[
                  Expanded(
                      child: TextFormField(
                        style: textStyle,
                        controller: termController,
                        keyboardType: TextInputType.number,
                        validator: (String value) {
                          if (value.isEmpty) {
                            // ignore: missing_return
                            return 'Please enter years';
                          }
                        },
                        decoration: InputDecoration(
                            labelText: "Term",
                            hintText: "Time(Years)",
                            labelStyle: textStyle,
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10.0))),
                      )),
                  Container(width: 25),
                  Expanded(
                      child: DropdownButton<String>(
                        items: _currencies.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: _currentItemSelected,
                        onChanged: (String newValSelected) {
                          _onDropDownSelected(newValSelected);
                        },
                      ))
                ],
              ),
              padding: EdgeInsets.all(10.0),
            ),
            Padding(
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme
                          .of(context)
                          .accentColor,
                      textColor: Theme
                          .of(context)
                          .primaryColorDark,
                      onPressed: () {
                        setState(() {
                          if (_formKey.currentState.validate()) {
                            this.displayResult = _calcutateTotal();
                          }
                        });
                      },
                      elevation: 5.0,
                      child: Text(
                        "Calculate",
                        textScaleFactor: 1.5,
                      ),
                    ),
                  ),
                  Container(
                    width: 10,
                  ),
                  Expanded(
                    child: RaisedButton(
                      color: Theme
                          .of(context)
                          .primaryColorDark,
                      textColor: Theme
                          .of(context)
                          .primaryColorLight,
                      onPressed: () {
                        setState(() {
                          _reset();
                        });
                      },
                      elevation: 5.0,
                      child: Text("Reset", textScaleFactor: 1.5),
                    ),
                  )
                ],
              ),
              padding: EdgeInsets.all(10.0),
            ),
            Padding(
              padding: EdgeInsets.all(10.0),
              child: Text(
                this.displayResult,
                style: textStyle,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/Calculator.ico');
    Image image = Image(
      image: assetImage,
      width: 125,
      height: 125,
    );
    return Container(
      child: image,
      margin: EdgeInsets.all(20.0),
    );
  }

  void _onDropDownSelected(String newValSelected) {
    setState(() {
      this._currentItemSelected = newValSelected;
    });
  }

  String _calcutateTotal() {
    double principal = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double totalAmount = principal + (principal * roi * term) / 100;

    String result =
        'After $term years,your investment become $totalAmount $_currentItemSelected';
    return result;
  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentItemSelected = _currencies[0];
  }
}
