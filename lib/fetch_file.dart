import 'package:flutter/services.dart';
import 'package:flutter/material.dart';

Future<String> fetchFileFromAssets(String assetsPath) {
  return rootBundle.loadString(assetsPath).then((file) => file.toString());
}

class SearchFile {
  getFutureBuilder(String input) {
    var count =
        1; // счетчик проходов, так как их два - первый со snapshot.data == null

    String text = ''; // текст, полученный при первом проходе цикла
    String text2 = ''; // текст, полученный при втором проходе цикла

    return FutureBuilder(
      future: fetchFileFromAssets('assets/$input.txt'),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
// дальше обрабатываем оба прохода по алгоритму с пустым snapshot.data и полным

        snapshot.hasData && count == 2
            ? text = snapshot.data
            : text = "Файл не найден";
        count == 1 ? text2 = "Ищем файл..." : text2 = text;
        input == ""
            ? text2 = ""
            : count++; // так как при загрузке тоже проходит цикл с пустым инпут

        return Container(
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Text(
              text2,
              style: TextStyle(fontSize: 18, color: Colors.black),
            ),
          ),
        );
      },
    );
  }
}
