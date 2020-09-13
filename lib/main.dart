import 'package:flutter/material.dart';
import 'package:future_lesson_app/fetch_file.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String input = ""; // ввод текста
  String value = ""; // имя файла под строкой ввода

  void _setSearch() {
    // обновление состояния при нажатии кнопки "Найти"
    setState(() {
      _controller.text != "" ? value = _controller.text + " file" : value = "";
// чтобы не писал file при пустом вводе текста
      input = _controller.text;
    });
  }

  TextEditingController _controller = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 15, left: 15, right: 15),
        child: Column(
          children: <Widget>[
            TextFormField(
              enabled: true,
              controller: _controller,
              style: TextStyle(fontSize: 17, color: Colors.black),
              decoration: InputDecoration(
                suffixIcon: MaterialButton(
                  // кнопка "Найти"
                  minWidth: 90,
                  height: 59,
                  onPressed: () {
                    _setSearch(); // обновляем состояние
                  },
                  color: Colors.black,
                  shape: UnderlineInputBorder(
                    borderRadius: const BorderRadius.only(
                      topRight: Radius.circular(10.0),
                      bottomRight: Radius.circular(10.0),
                    ),
                  ),
                  child: Text(
                    "Найти",
                    style: TextStyle(fontSize: 17),
                  ),
                  textColor: Colors.white,
                  onLongPress: () {},
                ),
                hintText: "Введите имя файла",
                hintStyle: TextStyle(color: Colors.grey),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.black, width: 3.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide(color: Colors.black, width: 3.0),
                ),
              ),
            ),
            Padding(
              // для отображения имени файла под строкой ввода
              padding: EdgeInsets.only(top: 20, left: 14),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  value, // текст под строкой ввода
                  style: TextStyle(fontSize: 18, color: Colors.black),
                ),
              ),
            ),
            ConstrainedBox(
              // для вывода из поиска файла
              constraints: BoxConstraints.tightFor(height: 150),
              child:
                  new SearchFile().getFutureBuilder(input), // в fetch_file.dart
            )
          ],
        ),
      ),
    );
  }
}
