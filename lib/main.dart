import 'package:desktop_updater/desktop_updater.dart';
import 'package:desktop_updater/updater_controller.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Upgrader Example',
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  int counter = 0;
  late DesktopUpdaterController desktopUpdaterController;
  String version = '';

  void incrementCounter() {
    setState(() {
      counter++;
    });
  }

  void decrementCounter() {
    setState(() {
      counter--;
    });
  }

  /*static const appcastURL = 'https://raw.githubusercontent.com/elavarasannedunchezhian/donation_archive/main/app_cast.xml';
  final updrader = Upgrader(
    client: http.Client(),
    clientHeaders: {},
    debugDisplayAlways: true,
    debugLogging: true,
    storeController: UpgraderStoreController(
      onWindows: () => UpgraderAppcastStore(appcastURL: appcastURL),
    ),
  );*/

  final appArchiveURL =  Uri.parse(
    'https://raw.githubusercontent.com/elavarasannedunchezhian/flutter_upgrader/main/app_archive.json',
  );

  @override
  void initState() {
    super.initState();
    getVersion();
    desktopUpdaterController = DesktopUpdaterController(
      appArchiveUrl: appArchiveURL,
    );
  }

  getVersion() async {
    version = await getAppVersion();
  }

  getAppVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Center(child: Text('Upgrader Example')),
      ),
      body: DesktopUpdateWidget(
        controller: desktopUpdaterController,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'You have pushed the button this many times:',
              ),
              Text(
                '$counter',
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        child: Text(
          'AppVersion: $version',
          textAlign: TextAlign.end,
        ),
      ),
    );
  }
}
