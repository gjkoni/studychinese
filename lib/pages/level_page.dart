import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:studychinese/common/global.dart';
import 'package:studychinese/db/db_manager.dart';
import 'package:studychinese/pages/web_page.dart';

class LevelPage extends StatefulWidget {
  const LevelPage({super.key});

  @override
  LevelPageState createState() => LevelPageState();
}

class LevelPageState extends State<LevelPage> {
  RxList<LevelCharacterData> list = <LevelCharacterData>[].obs;
  DBManager db = Global.db;
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _levelController = TextEditingController();
  final TextEditingController _characterController = TextEditingController();

  @override
  void initState() {
    queryData();
    super.initState();
  }

  void queryData() {
    db.allLevelCharacter().get().then((value) => {list.value = value});
  }

  String setUrl(String text) {
    return "http://localhost:8080/grnchinese/index.html?text=$text&size=${ScreenUtil().screenWidth}&cover";
  }

  Widget buildLevelList(RxList<LevelCharacterData> list) {
    return Container(
        padding: const EdgeInsets.all(0),
        decoration: const BoxDecoration(color: Colors.transparent),
        width: double.infinity,
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: list
                .map((e) => InkWell(
                    onLongPress: () {
                      showDialog(
                          context: context,
                          builder: (context) => SimpleDialog(
                                title: const Text(
                                  '是否要删除这条记录？',
                                  style: TextStyle(fontSize: 24),
                                ), //对话框标题内容
                                children: <Widget>[
                                  SimpleDialogOption(
                                    //选项按钮
                                    child: const Text(
                                      '删除',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () {
                                      db.deleteById(e.id);
                                      queryData();
                                      Navigator.of(context).pop(); //关闭对话框
                                    },
                                  ),
                                  SimpleDialogOption(
                                    child: const Text(
                                      '取消',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                  )
                                ],
                              ));
                    },
                    onTap: () {
                      Get.to(() => WebPage(
                            url: setUrl(e.character),
                            overScrollAlways: true,
                          ));
                    },
                    child: Container(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 10, bottom: 10),
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                      width: double.infinity,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(0),
                              child: Text(
                                e.title,
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 0, 103, 184),
                                    fontSize: 20),
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.all(0),
                              child: Text(
                                e.character.split('').join('、'),
                                style: TextStyle(
                                    color: Colors.grey.withOpacity(0.8),
                                    fontSize: 14),
                              ),
                            ),
                          ]),
                    )))
                .toList()));
  }

  void getDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Stack(
              clipBehavior: Clip.hardEdge,
              children: <Widget>[
                Positioned(
                  right: -40.0,
                  top: -40.0,
                  child: InkResponse(
                    onTap: () {
                      Navigator.of(context).pop();
                    },
                    child: const CircleAvatar(
                      backgroundColor: Colors.red,
                      child: Icon(Icons.close),
                    ),
                  ),
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: _levelController,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: '分类名称'),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(5.0),
                        child: TextFormField(
                          controller: _characterController,
                          maxLines: 10,
                          decoration: const InputDecoration(
                              border: OutlineInputBorder(), labelText: '分类生字'),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: SizedBox(
                            height: 50,
                            width: 300,
                            child: ElevatedButton(
                              onPressed: () {
                                // if (_formKey.currentState!.validate()) {
                                //   _formKey.currentState!.save();

                                // }
                                db
                                    .createEntry(_levelController.text,
                                        _characterController.text)
                                    .then((value) {
                                  if (value == 1) {
                                    debugPrint("1");
                                  } else {
                                    debugPrint("0");
                                  }
                                  queryData();
                                  Navigator.of(context).pop();
                                });
                              },
                              child: const Text("新建"),
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Container(
      padding: const EdgeInsets.all(0),
      child: SingleChildScrollView(
          child: Container(
              padding: const EdgeInsets.all(0),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            getDialog();
                          },
                          child: const Icon(Icons.add),
                        )
                      ],
                    ),
                  ),
                  Obx(() => buildLevelList(list)),
                ],
              ))),
    ));
  }
}
