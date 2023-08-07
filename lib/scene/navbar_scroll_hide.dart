
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class NavbarScroll extends StatefulWidget {
  NavbarScroll() : super();

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<NavbarScroll> {
  ScrollController? _scrollController;


  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }


  @override
  void dispose() {
    _scrollController!.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hide Bottom Navigation Bar'),
      ),
      body: Container(
        width: double.infinity,
        child: ListView.builder(
          controller: _scrollController,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text('Google $index'),
              onTap: () {},
            );
          },
        ),
      ),
      bottomNavigationBar: AnimatedBuilder(
        animation: _scrollController!,
        builder: (context, child) {
          return AnimatedContainer(
            duration: Duration(milliseconds: 100),
            height: _scrollController!.position.userScrollDirection == ScrollDirection.reverse ? 0: 60,
            child: child,
          );
        },
        child: BottomNavigationBar(
          backgroundColor: Colors.amber[200],
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.child_friendly),
              label: 'Child',
            ),
          ],
        ),
      ),
    );
  }
}