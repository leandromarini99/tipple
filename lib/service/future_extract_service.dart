
import 'package:flutter/material.dart';

class FutureExtract<T extends dynamic> {
  final Future<List<T>> futureList;
  FutureExtract(this.futureList);
  Widget extractList( Widget Function(List<T> data) buildWidget) {
    return FutureBuilder<List<T>>(
        future: futureList,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
               return Center(child: CircularProgressIndicator());
            default:
              // if (snapshot.hasError)
              //   return new Text('Error: ${snapshot.error}');
              // else
                return buildWidget(snapshot.data);
          }
        });
  }
}