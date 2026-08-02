# Worker Manager

Worker Manager is a powerful and easy-to-use library that helps you efficiently manage CPU-intensive tasks in your Flutter applications. It offers several advantages over traditional async programming or the built-in compute method. Note that the functions you are passing should either be static methods, globally defined functions or lambdas to ensure they are accessible from other isolates.

# New Feature - dynamicSpawn flag in init
By using this flag, worker_manager changes its behavior regarding isolate management. If this flag is set to true, new isolates will be spawned only if necessary and killed when they are no longer needed.

# Advantages

## Efficient Scheduling
This library schedules CPU-intensive functions to avoid skipping frames or freezes in your Flutter application. It ensures that your app runs smoothly, even when dealing with heavy computations.

## Reusable Isolates
Unlike the [compute](https://api.flutter.dev/flutter/foundation/compute-constant.html) method, which always creates a new Dart isolate, Worker Manager reuses existing isolates. This approach is more efficient and prevents overloading the CPU. When resources are not freed up, using the compute method may cause freezes and skipped frames.

## Cancelable Tasks
Worker Manager provides a cancellation functionality through the Cancelable class and its `cancel` method. This feature allows developers to free up resources when they are no longer needed, improving the app's performance and responsiveness.

## Gentle Cancellation
In addition to the standard cancellation method, Worker Manager offers a more gentle approach to cancellation. This new feature, `executeGentle`, does not immediately terminate the Dart isolate but instead provides a lambda function that can be called periodically within the task to check if it should be cancelled. This allows tasks to clean up and terminate gracefully.

## Inter-Isolate Communication
The library supports communication between isolates with the `executeWithPort` method. This feature enables sending progress messages or other updates between isolates, providing more control over your tasks.

## Gentle Cancellation with Port
The `executeGentleWithPort` method is another valuable feature of Worker Manager that combines gentle cancellation and inter-isolate communication. It accepts two arguments: a port for inter-isolate communication and a getter function `isCancelled` for gentle cancellation. This offers more flexibility and control, allowing tasks to communicate with other isolates while also providing an opportunity for graceful termination.

# Usage

## Execute the task
```dart
Cancelable<ResultType> cancelable = workerManager.execute<ResultType>(
  () async {
    // Your CPU-intensive function here
  },
  priority: WorkPriority.immediately,
);
```
## Execute a Task with Gentle Cancellation
```dart
Cancelable<ResultType> cancelable = workerManager.executeGentle<ResultType>(
  (isCanceled) async {
    while (!isCanceled()) {
      // Your CPU-intensive function here
      // Check isCanceled() periodically to decide whether to continue or break the loop
    }
  },
  priority: WorkPriority.immediately,
);
```
## Execute a Task with Inter-Isolate Communication
```dart
Cancelable<ResultType> cancelable = workerManager.executeWithPort<ResultType, MessageType>(
  (SendPort sendPort) async {
    // Your CPU-intensive function here
    // Use sendPort.send(message) to communicate with the main isolate
  },
  onMessage: (MessageType message) {
    // Handle the received message in the main isolate
  },
);
```

## Execute a Task with Gentle Cancellation and Inter-Isolate Communication
```dart
Cancelable<ResultType> cancelable = workerManager.executeGentleWithPort<ResultType, MessageType>(
  (SendPort sendPort, IsCanceled isCanceled) async {
    while (!isCanceled()) {
      // Your CPU-intensive function here
      // Use sendPort.send(message) to communicate with the main isolate
      // Check isCanceled() periodically to decide whether to continue or break the loop
    }
  },
  onMessage: (MessageType message) {
    // Handle the received message in the main isolate
  },
  priority: WorkPriority.immediately,
);
```

## Cancel a Task
```dart
cancelable.cancel();
```

## Dispose Worker Manager
```dart
await workerManager.dispose();
```

# Notice
Before isolates support in wasm, implementation of execution of task same as compute method from foundation

# Conclusion
By using Worker Manager, you can enjoy the benefits of efficient task scheduling, reusable isolates, cancellable tasks, and inter-isolate communication. It provides a clear advantage over traditional async programming and the built-in compute method, ensuring that your Flutter applications remain performant and responsive even when handling CPU-intensive tasks. The additional `executeGentleWithPort` feature provides both gentle cancellation and inter-isolate communication for your tasks, offering further control and efficiency.
