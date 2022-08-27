
import 'package:flutter/material.dart';
import 'package:flutter_app_messages/src/pages/messages_page.dart';
import 'package:flutter_app_messages/src/services/services.dart';
import 'package:provider/provider.dart';

class TabsPage extends StatelessWidget {

  

  @override
  Widget build(BuildContext context) {

    final postsService = Provider.of<PostsService>(context);

    
    return ChangeNotifierProvider(
      create: (_) =>new _NavigationModel(),
      child: Scaffold(
        body: (postsService.messages.length == 0)
          ? Center(child: CircularProgressIndicator(),)
          : _Pages(),  
        bottomNavigationBar: _Navigation(),
      ),
    );
  }
}

class _Navigation extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<_NavigationModel>(context);

    return BottomNavigationBar(
      backgroundColor: Theme.of(context).accentColor,
      selectedItemColor: Colors.black,
      currentIndex: navigationModel.actualPage,
      selectedFontSize: 15.0,
      onTap: (i) => navigationModel.actualPage = i,
      items: [
        BottomNavigationBarItem(icon: Icon(Icons.list_outlined), label: 'Messages' ),
        BottomNavigationBarItem(icon: Icon(Icons.star_outline), label: 'Favorites' )
      ]
    );
  }
}

class _Pages extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final navigationModel = Provider.of<_NavigationModel>(context);

    return Center(
      child: PageView(
        controller: navigationModel.pageController,
        //physics: BouncingScrollPhysics(),
        physics: NeverScrollableScrollPhysics(),
        children: [
       
          MessagesPage(),
          Container(
            color: Colors.green
          )
        ],
      )
    );
  }
}

class _NavigationModel with ChangeNotifier{
  
  int _actualPage = 0;
  PageController _pageController = new PageController(initialPage: 0);

  int get actualPage => this._actualPage;
  PageController get pageController => this._pageController;

  set actualPage( int value ) {
    this._actualPage = value;
    _pageController.animateToPage(value, duration: Duration(microseconds: 250), curve: Curves.easeOut );
    notifyListeners();
  }

}