void main() {
  performTasks();
}

void performTasks() async {
  task1();
  await task2();
  task1();
}

void task1() {
  String result = 'task 1 data';
  print('Task 1 complete');
}

Future<String> task2() async {
  String result;
  print('before');
  Duration time = Duration(seconds: 3);
  await Future.delayed(
    time,
    () {
      print('done');
      result = 'task 2 data';
    },
  );
  print('after');
  return result;
}

void task3(String str) {
  String result = 'task 3 data';
  print('3before');
  print('Task 3 complete $str');
}
