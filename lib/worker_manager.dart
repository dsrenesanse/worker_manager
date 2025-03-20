library;

export 'src/scheduling/task.dart';
export 'src/scheduling/work_priority.dart';
export 'src/port/send_port.dart';
export 'src/cancelable/cancelable.dart';

import 'dart:async';
import 'dart:math';
import 'package:collection/collection.dart';
import 'package:meta/meta.dart';
import 'package:worker_manager/src/cancelable/cancelable.dart';
import 'package:worker_manager/src/number_of_processors/processors_io.dart'
    if (dart.library.js_interop) 'package:worker_manager/src/number_of_processors/processors_web.dart'
    if (dart.library.html) 'package:worker_manager/src/number_of_processors/processors_web.dart';
import 'package:worker_manager/src/scheduling/task.dart';
import 'package:worker_manager/src/scheduling/work_priority.dart';
import 'package:worker_manager/src/worker/worker.dart';

part 'src/scheduling/executor.dart';

part 'src/scheduling/executor_logger.dart';
