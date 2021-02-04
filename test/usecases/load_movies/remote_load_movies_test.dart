import 'dart:io';

import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class RemoteLoadSurveys{
  Future<void> load() async{}
}

class HttpClientSpy extends Mock implements HttpClient{}

void main() {
  test('Should call HttpClient with correct values', () async{
    final sut = RemoteLoadSurveys();

    await sut.load();

    verify('');
  });
}