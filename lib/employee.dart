import 'package:Wrike_test/address.dart';
import 'package:json_object/json_object.dart';

class Employee {
  String id;
  String name;
  int age;
  Gender gender;
  String department;
  Address address;

  Employee(this.id, this.name, this.age, this.gender, this.department,
      this.address);
}

enum Gender {
  male,
  female
}

class EmployeeImpl extends JsonObject implements Employee {
  EmployeeImpl();

  factory EmployeeImpl.fromJsonString(string) {
    return new JsonObject.fromJsonString(string, new EmployeeImpl());
  }
}