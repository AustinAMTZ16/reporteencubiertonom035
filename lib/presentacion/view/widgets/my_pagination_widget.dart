import 'package:flutter/material.dart';

class MyPaginationwidget extends StatelessWidget {
  final void Function(int index) onItemSelect;
  final void Function() onBackSelect;
  final void Function() onNextSelect;
  const MyPaginationwidget({
    super.key,
    required int pages,
    required this.onItemSelect,
    required this.onBackSelect,
    required this.onNextSelect,
  }) : _pages = pages;

  final int _pages;

  @override
  Widget build(BuildContext context) {
    List<Widget> paginationWidgets = [];
    paginationWidgets.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: InkWell(
        focusColor: Colors.blueAccent,
        splashColor: Colors.blue,
        onTap: () {
          onBackSelect();
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            "<",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ));
    paginationWidgets.addAll(
      List.generate(_pages, (index) {
        //pagination items
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3),
          child: InkWell(
            focusColor: Colors.blueAccent,
            splashColor: Colors.blue,
            onTap: () {
              onItemSelect(index);
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                "${index + 1}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ),
        );
      }),
    );
    paginationWidgets.add(Padding(
      padding: const EdgeInsets.symmetric(horizontal: 3),
      child: InkWell(
        focusColor: Colors.blueAccent,
        splashColor: Colors.blue,
        onTap: () {
          onNextSelect();
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            ">",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    ));
    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: paginationWidgets),
    );
  }
}
