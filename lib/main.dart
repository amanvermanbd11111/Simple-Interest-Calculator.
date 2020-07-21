import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'S-I calculator',
    home: SIform(),
    theme: ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.indigo,
      accentColor: Colors.indigoAccent,
    ),
  ));
}

class SIform extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SIFormState();
  }
}

class _SIFormState extends State<SIform> {
  var _formKey = GlobalKey<FormState>();
  var _currrnces = ['Ruppes', 'Dollars', 'Pond', 'Euro'];
  final _minimumpadding = 5.0;
  var _currentcurriences = '';

  @override
  void initState() {
    super.initState();
    _currentcurriences = _currrnces[0];
  }

  var displayResult = '';

  TextEditingController principalController = TextEditingController();
  TextEditingController roiController = TextEditingController();
  TextEditingController termController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    TextStyle testStyle = Theme.of(context).textTheme.subtitle2;
    return Scaffold(
      //resizeToAvoidBottomPadding: false,
      appBar: AppBar(
        title: Text('Simple Interest Calculator'),
      ),
      body: Form(
          key: _formKey,
          child: Padding(
            padding: EdgeInsets.all(_minimumpadding * 2),
            child: ListView(
              children: <Widget>[
                getImageAsset(),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumpadding, bottom: _minimumpadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: testStyle,
                    controller: principalController,
                    validator: (String value) {

                      if (value.isEmpty) {
                        return 'Please enter a valid amount.';
                      }
                    },
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 15.0,
                      ),
                      labelText: 'Principal',
                      hintText: 'Enter Principal Eg. 12000',
                      labelStyle: testStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: _minimumpadding, bottom: _minimumpadding),
                  child: TextFormField(
                    keyboardType: TextInputType.number,
                    style: testStyle,
                    controller: roiController,
                    validator: (String value) {

                      if (value.isEmpty) {
                        return 'Please enter rate of interest.';
                      }
                    },
                    decoration: InputDecoration(
                      errorStyle: TextStyle(
                        color: Colors.amberAccent,
                        fontSize: 15.0,
                      ),
                      labelText: 'Rate Of Interest',
                      hintText: 'In Percent',
                      labelStyle: testStyle,
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(5.0)),
                    ),
                  ),
                ),
                Padding(
                    padding: EdgeInsets.only(
                        top: _minimumpadding, bottom: _minimumpadding),
                    child: Row(
                      children: <Widget>[
                        Expanded(
                          child: TextFormField(
                            keyboardType: TextInputType.number,
                            style: testStyle,
                            controller: termController,
                            validator: (String value) {

                              if (value.isEmpty) {
                                return 'Please enter Time.';
                              }
                            },
                            decoration: InputDecoration(
                              labelText: 'Terms ',
                              hintText: 'Time in Year',
                              labelStyle: testStyle,
                              errorStyle: TextStyle(
                                color: Colors.amberAccent,

                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5.0)),
                            ),
                          ),
                        ),
                        Container(
                          width: _minimumpadding * 5,
                        ),
                        Expanded(
                          child: DropdownButton<String>(
                            items: _currrnces.map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            value: _currentcurriences,
                            onChanged: (String newValueSelected) {
                              _dropdownSelecteditems(newValueSelected);
                            },
                          ),
                        ),
                      ],
                    )),
                Padding(
                  padding: EdgeInsets.only(
                      bottom: _minimumpadding, top: _minimumpadding),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).accentColor,
                          textColor: Theme.of(context).primaryColorDark,
                          child: Text(
                            'Calculated',
                            textScaleFactor: 1.3,
                          ),
                          onPressed: () {
                            setState(() {
                              if(_formKey.currentState.validate()) {
                                this.displayResult = _calculateTotalreturn();
                                }
                            });
                          },
                        ),
                      ),
                      Expanded(
                        child: RaisedButton(
                          color: Theme.of(context).primaryColorDark,
                          textColor: Theme.of(context).primaryColorLight,
                          child: Text(
                            'Reset',
                            textScaleFactor: 1.3,
                          ),
                          onPressed: () {
                            setState(() {
                              _reset();
                            });
                          },
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(_minimumpadding * 2),
                  child: Text(
                    this.displayResult,
                    style: testStyle,
                  ),
                ),
              ],
            ),
          )),
    );
  }

  Widget getImageAsset() {
    AssetImage assetImage = AssetImage('images/bank.png');
    Image image = Image(image: assetImage, height: 200.0, width: 200.0);
    return Container(
      child: image,
      margin: EdgeInsets.all(_minimumpadding * 5),
    );
  }

  void _dropdownSelecteditems(String newValueSelected) {
    setState(() {
      this._currentcurriences = newValueSelected;
    });
  }

  String _calculateTotalreturn() {
    double principle = double.parse(principalController.text);
    double roi = double.parse(roiController.text);
    double term = double.parse(termController.text);
    double totalAmount = principle + (principle * roi * term) / 100;
    String result =
        'After $term year your inverstment will be worth $totalAmount $_currentcurriences';
    return result;

  }

  void _reset() {
    principalController.text = '';
    roiController.text = '';
    termController.text = '';
    displayResult = '';
    _currentcurriences = _currrnces[0];
  }
}
