import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_concepts/logic/cubit/counter_cubit.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key, required this.title, required this.color}) : super(key: key);

  final String title;
  final Color color;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  GlobalKey<ScaffoldState> homeScreenKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            BlocConsumer<CounterCubit, CounterState>(
              builder: (context, state) {
                return Text(state.counterValue.toString(), style: Theme.of(context).textTheme.headline4);
              },
              listener: (context, state) {
                if (state.wasIncremented) {
                  ScaffoldMessenger.of(context).removeCurrentSnackBar();
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Incremented!'), duration: Duration(milliseconds: 300)),
                  );
                }
              },
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FloatingActionButton(
                    onPressed: () => BlocProvider.of<CounterCubit>(context).decrement(),
                    heroTag: Text('${widget.title}'),
                    tooltip: 'Decrement',
                    child: Icon(Icons.remove)),
                FloatingActionButton(
                    onPressed: () => BlocProvider.of<CounterCubit>(context).increment(),
                    heroTag: Text('${widget.title} 2nd'),
                    tooltip: 'Increment',
                    child: Icon(Icons.add)),
              ],
            ),
            SizedBox(height: 24),
            MaterialButton(
              color: Colors.redAccent,
              child: Text(
                'Go to Second Screen',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/second',
                  arguments: homeScreenKey,
                );
              },
            ),
            SizedBox(
              height: 24,
            ),
            MaterialButton(
              color: Colors.greenAccent,
              child: Text(
                'Go to Third Screen',
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  '/third',
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
