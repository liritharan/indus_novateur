import 'package:indus_task/api/employee.dart';
import 'package:indus_task/model/employee__model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class EmployeeScreen extends StatefulWidget {
  @override
  _EmployeeScreenState createState() => _EmployeeScreenState();
}

class _EmployeeScreenState extends State<EmployeeScreen> {
  @override
  Widget build(BuildContext context) {
    Dio dio = EmployeApi().getClient();

    return FutureBuilder(
      future: dio.get('/employees'),
      builder: (context, snapshot) {
        if (ConnectionState.done == snapshot.connectionState) {
          Response res = snapshot.data;
          List<Employee> models =
              EmployeApi().transformModelList(res.data['data']);
          print(res.data['data']);
          return ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: models.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.fromLTRB(20, 10, 20, 5),
                  child: Card(
                    elevation: 3.0,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              "Employee Name:      ${models[index].employeeName}"),
                          Text(
                              "Employee Id:        ${models[index].id.toString()}"),
                          Text(
                              "Employee Age:       ${models[index].employeeAge.toString()}"),
                          Text(
                              "Employee Salary:    ${models[index].employeeSalary.toString()}"),
                        ],
                      ),
                    ),
                  ),
                );
              });
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }
}
