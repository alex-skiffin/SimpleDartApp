// Copyright (c) 2016, alex-skiffin. All rights reserved. Use of this source code
// is governed by a BSD-style license that can be found in the LICENSE file.

import 'dart:html';

import 'package:Wrike_test/employee.dart';
import 'package:angular2/core.dart';

@Component(selector: 'my-app', templateUrl: 'app_component.html')
class AppComponent {
  var employees;
  var cities;
  var departments;

  AppComponent() {
    loadData();
  }

  void loadData() {
    var url = "https://gist.githubusercontent.com/bunopus/f48fbb06578003fb521c7c1a54fd906a/raw/e5767c1e7f172c6375f064a9441f2edd57a79f15/test_users.json";
    var request = HttpRequest.getString(url).then(onDataLoaded);
  }

  void onDataLoaded(String responseText) {
    var jsonString = responseText;
    employees = new EmployeeImpl.fromJsonString(jsonString);
  }
}