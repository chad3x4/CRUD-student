import 'package:connectdb/model/student.dart';
import 'package:flutter/material.dart';

import '../services/student_service.dart';
class EditStudent extends StatefulWidget {
  final Student student;
  const EditStudent({Key? key,required this.student}) : super(key: key);

  @override
  State<EditStudent> createState() => _EditStudentState();
}

class _EditStudentState extends State<EditStudent> {
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
  void initState() {
    setState(() {
      _studentNameController.text=widget.student.name??'';
      _studentAddrController.text=widget.student.addr??'';
      _studentClassController.text=widget.student.curr_class??'';
      _studentGPAController.text=widget.student.gpa??'';
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Sửa thông tin sinh viên"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10.0,
              ),
              const Center(
                child: Text(
                  'Cập nhật thông tin',
                  style: TextStyle(
                      fontSize: 24,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.w500),
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              TextField(
                  controller: _studentNameController,
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: 'Nhập họ và tên',
                    labelText: 'Họ và tên',
                    errorText:
                    _validateName ? 'Họ và tên không được để trống' : null,
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
                        ? 'GPA không được để trống'
                        : null,
                  )),
              const SizedBox(
                height: 30.0,
              ),
              Row(
                children: [
                  Center(
                    widthFactor: 1.8,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.redAccent,
                            textStyle: const TextStyle(fontSize: 18)),
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
                            // print("Good Data Can Save");
                            var _student = Student();
                            _student.id=widget.student.id;
                            _student.name = _studentNameController.text;
                            _student.addr = _studentAddrController.text;
                            _student.curr_class = _studentClassController.text;
                            _student.gpa = _studentGPAController.text;
                            var result = await _studentService.updateStudent(_student);
                            Navigator.pop(context,result);
                          }
                        },
                        child: const Text('Cập nhật')),
                  ),
                  Center(
                    widthFactor: 1.5,
                    child: TextButton(
                        style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.blueGrey,
                            textStyle: const TextStyle(fontSize: 18)),
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