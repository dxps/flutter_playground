import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  //
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  //
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
        actions: <Widget>[
          IconButton(icon: Icon(Icons.search), onPressed: () {}),
          IconButton(icon: Icon(Icons.more_vert), onPressed: () {}),
        ],
        flexibleSpace: SafeArea(
          child: Icon(Icons.photo_camera, size: 70, color: Colors.white70),
        ),
        bottom: PopupMenuButtonWidget(),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: SafeArea(
          // SingleChildScrollView allows scrolling and view hidden widgets.
          // otherwise, you'll see the overflow (yellow and black) bar.
          child: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                const ContainerWithBoxDecorationWidget(),
                Divider(),
                const ColumnWidget(),
                Divider(),
                const RowWidget(),
                Divider(),
                const ColumnAndRowNestingWidget(),
                Divider(),
                const ButtonsWidget(),
                Divider(),
                const ButtonBarWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ContainerWithBoxDecorationWidget extends StatelessWidget {
  //
  const ContainerWithBoxDecorationWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 100,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(80),
              bottomRight: Radius.circular(20),
            ),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Colors.white, Colors.lightGreen.shade500],
            ),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 10, offset: Offset(0, 10)),
            ],
          ),
          child: Center(
            child: RichText(
              text: TextSpan(
                text: 'Flutter World',
                style: TextStyle(
                  fontSize: 24,
                  fontStyle: FontStyle.italic,
                  color: Colors.deepPurple,
                  decoration: TextDecoration.underline,
                  decorationStyle: TextDecorationStyle.dotted,
                ),
                children: <TextSpan>[
                  TextSpan(text: ' for '),
                  TextSpan(
                    text: 'Mobile',
                    style: TextStyle(
                      color: Colors.deepOrange,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class ColumnWidget extends StatelessWidget {
  //
  const ColumnWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Text('Column 1'),
        Divider(),
        Text('Column 2'),
        Divider(),
        Text('Column 3'),
      ],
    );
  }
}

class RowWidget extends StatelessWidget {
  //
  const RowWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text('Row 1'),
        Padding(padding: EdgeInsets.all(16)),
        Text('Row 2'),
        Padding(padding: EdgeInsets.all(16)),
        Text('Row 3'),
      ],
    );
  }
}

class ColumnAndRowNestingWidget extends StatelessWidget {
  //
  const ColumnAndRowNestingWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Text('Columns and Row Nesting 1'),
        Text('Columns and Row Nesting 2'),
        Text('Columns and Row Nesting 3'),
        Padding(padding: EdgeInsets.all(16.0)),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('Row Nesting 1'),
            Text('Row Nesting 2'),
            Text('Row Nesting 3'),
          ],
        ),
      ],
    );
  }
}

class TodoMenuItem {
  //
  final String title;
  final Icon icon;

  TodoMenuItem({this.title, this.icon});
}

// Create a List of Menu Item for PopupMenuButton
List<TodoMenuItem> foodMenuList = [
  TodoMenuItem(title: 'Fast Food', icon: Icon(Icons.fastfood)),
  TodoMenuItem(title: 'Remind Me', icon: Icon(Icons.add_alarm)),
  TodoMenuItem(title: 'Flight', icon: Icon(Icons.flight)),
  TodoMenuItem(title: 'Music', icon: Icon(Icons.audiotrack)),
];

class PopupMenuButtonWidget extends StatelessWidget implements PreferredSizeWidget {
  //
  const PopupMenuButtonWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.lightGreen.shade100,
      height: preferredSize.height,
      width: double.infinity,
      child: Center(
        child: PopupMenuButton<TodoMenuItem>(
          icon: Icon(Icons.view_list),
          onSelected: ((valueSelected) {
            print('valueSelected: ${valueSelected.title}');
          }),
          itemBuilder: (BuildContext context) {
            return foodMenuList.map((TodoMenuItem todoMenuItem) {
              return PopupMenuItem<TodoMenuItem>(
                value: todoMenuItem,
                child: Row(
                  children: <Widget>[
                    Icon(todoMenuItem.icon.icon),
                    Padding(padding: EdgeInsets.all(8.0)),
                    Text(todoMenuItem.title),
                  ],
                ),
              );
            }).toList();
          },
        ),
      ),
    );
  }

  @override
  // implementation of the getter preferredSize, as defined by PreferredSizeWidget
  Size get preferredSize => Size.fromHeight(75.0);

  //
}

class ButtonsWidget extends StatelessWidget {
  //
  const ButtonsWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(16.0)),
            FlatButton(onPressed: () {}, child: Text('Flag')),
            Padding(padding: EdgeInsets.all(16.0)),
            FlatButton(
              onPressed: () {},
              child: Icon(Icons.flag),
              color: Colors.lightGreen,
              textColor: Colors.white,
            ),
          ],
        ),
        Divider(),
        Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(16.0)),
            RaisedButton(child: Text('Save'), onPressed: () {}),
            Padding(padding: EdgeInsets.all(16.0)),
            RaisedButton(
              onPressed: () {},
              child: Icon(Icons.save),
              color: Colors.lightGreen,
            ),
          ],
        ),
        Divider(),
        Row(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(16.0)),
            IconButton(icon: Icon(Icons.flight), onPressed: () {}),
            Padding(padding: EdgeInsets.all(16.0)),
            IconButton(
              icon: Icon(Icons.flight),
              iconSize: 42.0,
              color: Colors.lightGreen,
              tooltip: 'Flight',
              onPressed: () {},
            ),
          ],
        ),
        Divider(),
      ],
    );
  }
}

class ButtonBarWidget extends StatelessWidget {
  //
  const ButtonBarWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white70,
      child: ButtonBar(
        alignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          IconButton(
            icon: Icon(Icons.map),
            onPressed: () {},
          ),
          IconButton(icon: Icon(Icons.airport_shuttle), onPressed: () {}),
          IconButton(icon: Icon(Icons.brush), highlightColor: Colors.purple, onPressed: () {}),
        ],
      ),
    );
  }
}
