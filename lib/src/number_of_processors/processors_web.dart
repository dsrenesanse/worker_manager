import 'dart:math';
import 'package:web/web.dart' as web;

/// Returns the number of available processors for concurrent execution.
///
/// This function uses the `navigator.hardwareConcurrency` API to determine
/// the number of available threads. It returns n - 1 threads, where n is
/// the number of available threads, with one thread reserved for the main
/// thread to avoid skipping frames.

int get numberOfProcessors {
  // Get the hardware concurrency, defaulting to 1 if not available
  final concurrency = web.window.navigator.hardwareConcurrency;

  // Subtract 1 and ensure the result is at least 1
  return max(concurrency - 1, 1);
}
