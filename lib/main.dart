import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'CookAssistafffffnt',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cook2222CookAggdsssgssistant'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // 광고 배너 위치
            Container(
              height: 200,
              color: Colors.grey[300],
              child: Center(
                child: Text('광고 배너'),
              ),
            ),
            _buildSectionTitle(context, '나의 냉장고', () {
              // '나의 냉장고' 페이지로 이동하는 로직
            }),
            _buildHorizontalList(),
            _buildSectionTitle(context, '유저가 만든 레시피', () {
              // '유저가 만든 레시피' 페이지로 이동하는 로직
            }),
            _buildHorizontalList(),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '홈'),
          BottomNavigationBarItem(icon: Icon(Icons.group), label: '커뮤니티'),
          BottomNavigationBarItem(icon: Icon(Icons.create), label: '레시피 제작'),
          BottomNavigationBarItem(icon: Icon(Icons.account_circle), label: '마이페이지'),
        ],
        selectedItemColor: Color(0xFF1A936F),
      ),
    );
  }

  Widget _buildSectionTitle(BuildContext context, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Text(title, style: Theme.of(context).textTheme.headline6),
          GestureDetector(
            onTap: onTap,
            child: Text('더보기', style: TextStyle(color: Color(0xFF1A936F))),
          ),
        ],
      ),
    );
  }

  Widget _buildHorizontalList() {
    return Container(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          return Container(
            width: 120,
            child: Card(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.kitchen, size: 50),
                  Text('소비기한: 00일'),
                  Text('식재료 이름'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
