import 'package:indus_task/model/employee__model.dart';
import 'package:dio/dio.dart';

class EmployeApi {
  Dio _dio;
  static final EmployeApi _singleton = EmployeApi._internal();

  factory EmployeApi() => _singleton;

  Dio getClient() => _dio;

  EmployeApi._internal() {
    _dio = Dio(BaseOptions(baseUrl: 'https://dummy.restapiexample.com/api/v1'));
  }

  List<Employee> transformModelList(List<dynamic> map) {
    List<Employee> models = List<Employee>();
    map.forEach((element) {
      models.add(Employee.fromJson(element));
    });
    return models;
  }
}
