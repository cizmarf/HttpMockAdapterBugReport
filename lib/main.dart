import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:http_mock_adapter/http_mock_adapter.dart';

void main() async {
  print('Program Starts');
  WidgetsFlutterBinding.ensureInitialized();
  print('WidgetsFlutterBinding initialized');

  final dio = Dio();
  final dioAdapter = DioAdapter(dio: dio);

  dioAdapter.onGet(
    'https://example.com/user/foo',
    (server) => server.reply(
      200,
      {
        'name': 'Foo',
        'surname': 'Bar',
      },
      delay: const Duration(seconds: 1),
    ),
  );

  dioAdapter.onGet(
    'https://example.com/user/jane',
    (server) => server.reply(
      200,
      """{
        'name': 'Jane',
        'surname': 'Doe',
      }""",
      headers: {
        'set-cookie': ['a', 'b']
      },
      delay: const Duration(seconds: 1),
    ),
  );

  dioAdapter.onGet(
    'https://example.com/user/john',
    (server) => server.reply(
      200,
      {
        'name': 'John',
        'surname': 'Doe',
      },
      headers: {
        'set-cookie': ['a', 'b']
      },
      delay: const Duration(seconds: 1),
    ),
  );

  print('>>>>>>>>>>>>>>>>>>>>');
  print('Fetching Foo');

  try {
    Response response = await dio.get(
      'https://example.com/user/foo',
    );
    print(response.data);
  } catch (e) {
    print('Error');
  }

  print('Fetching Foo finished');


  print('>>>>>>>>>>>>>>>>>>>>');
  print('Fetching Jane');

  try {
    Response response = await dio.get(
      'https://example.com/user/jane',
    );
    print(response.data);
  } catch (e) {
    print('Error');
  }

  print('Fetching Jane finished');

  print('>>>>>>>>>>>>>>>>>>>>');
  print('Fetching John');

  try {
    Response response = await dio.get(
      'https://example.com/user/john',
    );
    print(response.data);
  } catch (e) {
    print('ERROR HAPPENS HERE');
  }

  print('Fetching John finished');

  runApp(
    MaterialApp(
      home: Text('App'),
    ),
  );
}
