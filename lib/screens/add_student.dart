import 'package:connectdb/model/student.dart';
import 'package:flutter/material.dart';

import '../services/student_service.dart';

class AddStudent extends StatefulWidget {
  const AddStudent({Key? key}) : super(key: key);

  @override
  State<AddStudent> createState() => _AddStudentState();
}

class _AddStudentState extends State<AddStudent> {
  final _studentNameController = TextEditingController();
  final _studentAddrController = TextEditingController();
  final _studentClassController = TextEditingController();
  final _studentGPAController = TextEditingController();
  bool _validateName = false;
  bool _validateAddr = false;
  bool _validateClass = false;
  bool _validateGPA = false;
  final _studentService = StudentService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Thêm học sinh"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Center(
                child: Text(
                  'Thêm học sinh mới',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blue,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _studentNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Nhập họ và tên',
                    labelText: 'Họ và tên',
                    errorText:
                    _validateName ? 'Họ tên không được để trống' : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _studentAddrController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Nhập địa chỉ',
                    labelText: 'Địa chỉ',
                    errorText: _validateAddr
                        ? 'Địa chỉ không được để trống'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _studentClassController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Lớp sinh viên',
                    labelText: 'Lớp',
                    errorText: _validateClass
                        ? 'Lớp không được để trống'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              TextField(
                  controller: _studentGPAController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Điểm GPA',
                    labelText: 'GPA',
                    errorText: _validateGPA
                        ? 'Điểm GPA không được để trống'
                        : null,
                  )),
              const SizedBox(
                height: 20.0,
              ),
              Row(
                children: [
                  Center(
                    widthFactor: 2,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blue,
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () async {
                          setState(() {
                            _studentNameController.text.isEmpty
                                ? _validateName = true
                                : _validateName = false;
                            _studentAddrController.text.isEmpty
                                ? _validateAddr = true
                                : _validateAddr = false;
                            _studentClassController.text.isEmpty
                                ? _validateClass = true
                                : _validateClass = false;
                            _studentGPAController.text.isEmpty
                                ? _validateGPA = true
                                : _validateGPA = false;

                          });
                          if (_validateName == false &&
                              _validateAddr == false &&
                              _validateClass == false &&
                              _validateGPA == false) {
                            var _student = Student();
                            _student.name = _studentNameController.text;
                            _student.addr = _studentAddrController.text;
                            _student.curr_class = _studentClassController.text;
                            _student.gpa = _studentGPAController.text;
                            var result=await _studentService.saveStudent(_student);
                            Navigator.pop(context,result);
                          }
                        },
                        child: const Text('Lưu')),
                  ),
                  Center(
                    widthFactor: 2,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.red,
                            textStyle: const TextStyle(fontSize: 20)),
                        onPressed: () {
                          _studentNameController.text = '';
                          _studentAddrController.text = '';
                          _studentClassController.text = '';
                          _studentGPAController.text = '';
                        },
                        child: const Text('Làm mới')),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}