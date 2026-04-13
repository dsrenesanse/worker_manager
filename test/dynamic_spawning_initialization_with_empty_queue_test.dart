// ignore_for_file: invalid_use_of_visible_for_testing_member
import 'package:test/test.dart';
import 'package:worker_manager/worker_manager.dart';

void main() {
  setUp(() async => await workerManager.dispose());
  tearDown(() async => await workerManager.dispose());

  test('init() kills idle worker when dynamicSpawning=true and no tasks queued',
      () async {
    await workerManager.init(dynamicSpawning: true);

    expect(workerManager.pool.isNotEmpty, isTrue);
    expect(
      workerManager.pool.every((w) => !w.initialized),
      isTrue,
      reason:
          'init() must not leave idle workers alive when dynamicSpawning=true',
    );
  });
}
