import 'package:flutter/material.dart';
import 'package:home_widget/home_widget.dart';

@pragma('vm:entry-point')
Future<void> homeWidgetInteractivityCallback(Uri? uri) async {
  // Set App Group Id for iOS
  await HomeWidget.setAppGroupId(
    'group.es.antonborri.homeWidgetWorkshop.workshopWidget',
  );

  // Get Data from home_widget
  final counterValue = await HomeWidget.getWidgetData<int>(
    'counter',
    defaultValue: 0,
  );
  final newValue = counterValue! + 1;

  // Store Data in home_widget
  await HomeWidget.saveWidgetData<int>('counter', newValue);

  // Update Homescreen Widget
  await HomeWidget.updateWidget(
    name: 'WorkshopWidget',
    iOSName: 'WorkshopWidget',
  );
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int? _counter;

  @override
  void initState() {
    super.initState();
    _renderButtonToHomeWidget();
    HomeWidget.registerInteractivityCallback(homeWidgetInteractivityCallback);
  }

  Future<void> _incrementCounter() async {
    // Set App Group Id for iOS
    await HomeWidget.setAppGroupId(
      'group.es.antonborri.homeWidgetWorkshop.workshopWidget',
    );

    // Get Data from home_widget
    final counterValue = await HomeWidget.getWidgetData<int>(
      'counter',
      defaultValue: 0,
    );
    final newValue = counterValue! + 1;

    // Store Data in home_widget
    await HomeWidget.saveWidgetData<int>('counter', newValue);

    // Update Homescreen Widget
    await HomeWidget.updateWidget(
      name: 'WorkshopWidget',
      iOSName: 'WorkshopWidget',
    );

    if (mounted) {
      setState(() {
        _counter = newValue;
      });
    }
  }

  Future<void> _renderButtonToHomeWidget() async {
    final myWidget = Center(
      child: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.flutter_dash),
      ),
    );

    // Set App Group Id for iOS
    await HomeWidget.setAppGroupId(
      'group.es.antonborri.homeWidgetWorkshop.workshopWidget',
    );

    // Render Widget
    await HomeWidget.renderFlutterWidget(
      myWidget,
      key: 'dash',
      logicalSize: const Size.square(100),
    );

    // Update Homescreen Widget
    await HomeWidget.updateWidget(
      name: 'WorkshopWidget',
      iOSName: 'WorkshopWidget',
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '${_counter ?? '-'}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
