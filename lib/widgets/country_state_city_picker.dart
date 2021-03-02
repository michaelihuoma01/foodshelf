library country_state_city_picker;

import 'package:flutter/services.dart' show rootBundle;
import 'dart:convert';
import 'package:flutter/material.dart';
import '../models/select_status_model.dart' as StatusModel;

class SelectState extends StatefulWidget {
  final ValueChanged<String> onCountryChanged;
  final ValueChanged<String> onStateChanged;
  final ValueChanged<String> onCityChanged;

  const SelectState(
      {Key key, this.onCountryChanged, this.onStateChanged, this.onCityChanged})
      : super(key: key);

  @override
  _SelectStateState createState() => _SelectStateState();
}

class _SelectStateState extends State<SelectState> {
  List<String> _cities = ["Choose City"];
  List<String> _country = ["Choose  Country"];
  String _selectedCity = "Choose City";
  String _selectedCountry = "Choose  Country";
  String _selectedState = "Choose City";
  List<String> _states = ["Choose City"];
  var responses;

  @override
  void initState() {
    getCounty();
    super.initState();
  }

  Future getResponse() async {
    var res = await rootBundle.loadString('assets/country.json');
    // await DefaultAssetBundle.of(context).loadString('assets/country.json');
    return jsonDecode(res);
  }

  Future getCounty() async {
    var countryres = await getResponse() as List;
    countryres.forEach((data) {
      var model = StatusModel.StatusModel();
      model.name = data['name'];
      model.emoji = data['emoji'];
      setState(() {
        _country.add(model.emoji + "    " + model.name);
        // _country..addAll(takecountry2);
      });
    });

    return _country;
  }

  Future getState() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.emoji + "    " + item.name == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      setState(() {
        var name = f.map((item) => item.name).toList();
        for (var statename in name) {
          print(statename.toString());

          _states.add(statename.toString());
        }
      });
    });

    return _states;
  }

  Future getCity() async {
    var response = await getResponse();
    var takestate = response
        .map((map) => StatusModel.StatusModel.fromJson(map))
        .where((item) => item.emoji + "    " + item.name == _selectedCountry)
        .map((item) => item.state)
        .toList();
    var states = takestate as List;
    states.forEach((f) {
      var name = f.where((item) => item.name == _selectedState);
      var cityname = name.map((item) => item.city).toList();
      cityname.forEach((ci) {
        setState(() {
          var citiesname = ci.map((item) => item.name).toList();
          //  print(citiesname);
          for (var citynames in citiesname) {
            print(citynames.toString());

            _cities.add(citynames.toString());
          }
        });
      });
    });
    return _cities;
  }

  void _onSelectedCountry(String value) {
    setState(() {
      _selectedState = "Choose City";
      _states = ["Choose City"];
      _selectedCountry = value;
      this.widget.onCountryChanged(value);
      getState();
    });
  }

  void _onSelectedState(String value) {
    setState(() {
      _selectedCity = "Choose City";
      _cities = ["Choose City"];
      _selectedState = value;
      this.widget.onStateChanged(value);
      getCity();
    });
  }

  void _onSelectedCity(String value) {
    setState(() {
      _selectedCity = value;
      this.widget.onCityChanged(value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      // crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Expanded(
          child: Container(
            child: DropdownButton<String>(
              isExpanded: true,
              items: _country.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Row(
                    children: [Expanded(child: Text(dropDownStringItem))],
                  ),
                );
              }).toList(),
              onChanged: (value) => _onSelectedCountry(value),
              value: _selectedCountry,
            ),
          ),
        ),
        SizedBox(width: 30),
        Expanded(
          child: Container(
            child: DropdownButton<String>(
              isExpanded: true,
              items: _states.map((String dropDownStringItem) {
                return DropdownMenuItem<String>(
                  value: dropDownStringItem,
                  child: Text(dropDownStringItem),
                );
              }).toList(),
              // onChanged: (value) => print(value),
              onChanged: (value) => _onSelectedState(value),
              value: _selectedState,
            ),
          ),
        ),
        // DropdownButton<String>(
        //   isExpanded: true,
        //   items: _cities.map((String dropDownStringItem) {
        //     return DropdownMenuItem<String>(
        //       value: dropDownStringItem,
        //       child: Text(dropDownStringItem),
        //     );
        //   }).toList(),
        //   // onChanged: (value) => print(value),
        //   onChanged: (value) => _onSelectedCity(value),
        //   value: _selectedCity,
        // ),
        // SizedBox(
        //   height: 10.0,
        // ),
      ],
    );
  }
}
