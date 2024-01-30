import 'package:flutter/material.dart';

class MyTabbedPage extends StatefulWidget {
  const MyTabbedPage({Key? key}) : super(key: key);
  @override
  State<MyTabbedPage> createState() => _MyTabbedPageState();
}

class _MyTabbedPageState extends State<MyTabbedPage>
    with SingleTickerProviderStateMixin {
  List<Widget> myTabs = [
    SizedBox(
      width: 20.0,
      child: Tab(text: 'hello'),
    ),
    SizedBox(
      width: 70,
      child: Tab(text: 'world'),
    ),
  ];

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: myTabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: TabBarView(
        controller: _tabController,
        children: myTabs.map((Widget tab) {
          final String label = "Test";
          return Center(
            child: Text(
              'This is the $label tab',
              style: const TextStyle(fontSize: 36),
            ),
          );
        }).toList(),
      ),
      appBar: AppBar(
        bottom: TabBar(
          controller: _tabController,
          tabs: myTabs,
          isScrollable: true,
        ),
      ),
    );
  }
}