import 'package:flutter_test/flutter_test.dart';


import 'package:gesco/app/build/build_repository.dart';

class MockClient  {}

void main() {
  BuildRepository repository;
  // MockClient client;

  setUp(() {
    // repository = BuildRepository();
    // client = MockClient();
  });

  group('BuildRepository Test', () {
    //  test("First Test", () {
    //    expect(repository, isInstanceOf<BuildRepository>());
    //  });

    test('returns a Post if the http call completes successfully', () async {
      //    when(client.get('https://jsonplaceholder.typicode.com/posts/1'))
      //        .thenAnswer((_) async =>
      //            Response(data: {'title': 'Test'}, statusCode: 200));
      //    Map<String, dynamic> data = await repository.fetchPost(client);
      //    expect(data['title'], 'Test');
    });
  });
}
