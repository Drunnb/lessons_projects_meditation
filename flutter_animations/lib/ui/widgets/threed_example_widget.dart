import 'package:flutter/material.dart';

class ExampleWidget extends StatefulWidget {
  const ExampleWidget({super.key});

  @override
  State<ExampleWidget> createState() => _ExampleWidgetState();
}

class _ExampleWidgetState extends State<ExampleWidget> {
  final _listKey = GlobalKey<AnimatedListState>();
  final _data = [1, 2, 3, 4];
  void _insert() {
    final element = (_data.isEmpty ? 0 : _data.last) + 1;
    _data.add(element);
    final index = _data.length - 1;
    _listKey.currentState?.insertItem(index);
  }

  void _removeAtIndex(int index) {
    // ignore: unused_local_variable
    final element = _data.removeAt(index);
    _listKey.currentState?.removeItem(index, (context, animation) {
      return SlideTransition(
        position: animation.drive(Tween<Offset>(
          begin: const Offset(1, 0),
          end: const Offset(0, 0),
        )),
        child: Container(
          width: double.infinity,
          height: 40,
          color: Colors.redAccent,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _insert,
        child: const Icon(Icons.add),
      ),
      body: SafeArea(
        child: AnimatedList(
          key: _listKey,
          initialItemCount: _data.length,
          itemBuilder: (context, index, animation) {
            return SizeTransition(
              sizeFactor: animation,
              child: GestureDetector(
                onTap: () => _removeAtIndex(index),
                child: _RowWidget(text: _data[index]),
              ),
            );
          },
        ),
      ),
    );
  }
}

class _RowWidget extends StatelessWidget {
  const _RowWidget({
    required this.text,
  });

  final int text;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("$text"),
        ),
      ),
    );
  }
}
