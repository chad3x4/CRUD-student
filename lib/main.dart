import 'package:connectdb/model/Student.dart';
import 'package:connectdb/screens/EditStudent.dart';
import 'package:connectdb/screens/AddStudent.dart';
import 'package:connectdb/screens/ViewStudent.dart';
import 'package:connectdb/services/studentService.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Students Management',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<Student> _studentList = <Student>[];
  final _studentService = StudentService();

  getAllStudentsDetails() async {
    var students = await _studentService.readAllStudents();
    _studentList = <Student>[];
    students.forEach((student) {
      setState(() {
        var studentModel = Student();
        studentModel.id = student['id'];
        studentModel.name = student['name'];
        studentModel.addr = student['address'];
        studentModel.curr_class = student['class'];
        studentModel.gpa = student['gpa'];
        _studentList.add(studentModel);
      });
    });
  }

  @override
  void initState() {
    getAllStudentsDetails();
    super.initState();
  }

  _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }
  //Hiển thị dialog xóa
  _deleteFormDialog(BuildContext context, studentId) {
    return showDialog(
        context: context,
        builder: (param) {
          return AlertDialog(
            title: const Text(
              'Bạn chắc chắn muốn xóa?',
              style: TextStyle(color: Colors.blue, fontSize: 20),
            ),
            actions: [
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.red),
                  onPressed: ()  async{
                    var result = await _studentService.deleteStudent(studentId);
                    if (result != null) {
                      Navigator.pop(context);
                      setState(() {
                        _studentList.removeWhere((student) => student.id == studentId);
                      });
                      _showSuccessSnackBar('Xóa sinh viên thành công!');
                    }
                  },
                  child: const Text('Xóa')),
              TextButton(
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('Không'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Quản lý sinh viên")),
      ),
      body: ListView.builder(
          itemCount: _studentList.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ViewStudent(
                            student: _studentList[index],
                          )));
                },
                leading: const Icon(
                  Icons.person,
                  color: Colors.blue,
                  size: 30,
                ),
                title: Text(_studentList[index].name ?? '', style: const TextStyle(color: Colors.black54),),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      width: 55,
                      height: double.infinity,
                      child: TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => EditStudent(
                                      student: _studentList[index],
                                    ))).then((data) {
                              if (data != null) {
                                getAllStudentsDetails();
                                _showSuccessSnackBar(
                                    'Cập nhật thông tin thành công');
                              }
                            });
                          },
                        child: const Text(
                          'Sửa',
                          style: TextStyle(color: Colors.cyan, fontSize: 13),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 40,
                      height: double.infinity,
                      child: TextButton(
                        onPressed: () {
                          _deleteFormDialog(context, _studentList[index].id);
                        },
                        child: const Text(
                          'Xóa',
                          style: TextStyle(color: Colors.red, fontSize: 13),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddStudent()))
              .then((data) {
            if (data != null) {
              getAllStudentsDetails();
              _showSuccessSnackBar('Thêm sinh viên thành công!');
            }
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}