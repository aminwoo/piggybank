import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(const MyApp());
}

enum Category {
  income('Income', Icons.attach_money_rounded),
  food('Food', Icons.fastfood_rounded),
  groceries('Groceries', Icons.local_grocery_store_outlined),
  utilities('Utilities', Icons.bike_scooter),
  entertainment('Entertainment', Icons.music_note);

  const Category(this.label, this.icon);
  final String label;
  final IconData icon;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PiggyBank',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.blue,
            title: const Text("Piggy Bank"),
          ),
          body: const TabBarView(
            children: <Widget>[
              Center(
                child: TransactionForm(),
              ),
              Center(
                child: Text("Trends"),
              ),
              Center(
                child: Balance(),
              ),
              Center(
                child: Text("Options"),
              ),
            ],
          ),
          bottomNavigationBar: Menu(),
        )
      ),
    );
  }
}


// Define a custom Form widget.
class TransactionForm extends StatefulWidget {
  const TransactionForm({super.key});

  @override
  State<TransactionForm> createState() => _TransactionFormState();
}

// Define a corresponding State class.
// This class holds data related to the Form.
class _TransactionFormState extends State<TransactionForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    final text = myController.text;
    print('Second text field: $text (${text.characters.length})');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Transaction'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => {},
        tooltip: 'Add new item',
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.account_balance_rounded),
                hintText: 'Account Name',
                labelText: 'Account *',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.attach_money_rounded),
                hintText: 'Cost (\$)',
                labelText: 'Amount *',
              ),
            ),
            DropdownButtonFormField(
              items: Category.values.map((Category category) {
                return DropdownMenuItem(
                    value: category.label,
                    child: Row(
                      children: <Widget>[
                        Icon(category.icon),
                        Padding(padding: const EdgeInsets.symmetric(horizontal: 10), child: Text(category.label)),
                      ],
                    )
                );
                }).toList(),
                onChanged: (newValue) {
                  print(newValue);
                },
                decoration: const InputDecoration(
                  icon: Icon(Icons.category),
                  labelText: 'Category',
                ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: InputDatePickerFormField(fieldLabelText: 'Date', initialDate: DateTime.now(), firstDate: DateTime(2015, 1), lastDate: DateTime(2100), ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(onPressed: () {}, child: const Text('Submit')),
            )
            ],
        ),
      ),
    );
  }
}

class Balance extends StatefulWidget {
  const Balance({super.key});

  @override
  State<Balance> createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final myController = TextEditingController();

  @override
  void initState() {
    super.initState();

    // Start listening to changes.
    myController.addListener(_printLatestValue);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    myController.dispose();
    super.dispose();
  }

  void _printLatestValue() {
    final text = myController.text;
    print('Second text field: $text (${text.characters.length})');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () => {},
        tooltip: 'Add new item',
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.account_balance),
                hintText: 'Amount of money in bank',
                labelText: 'Bank *',
              ),
            ),
            TextFormField(
              decoration: const InputDecoration(
                icon: Icon(Icons.money),
                hintText: 'Cost (\$)',
                labelText: 'Amount *',
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: ElevatedButton(onPressed: () {}, child: const Text('Submit')),
            )
          ],
        ),
      ),
    );
  }
}


Widget Menu() {
  return Container(
    color: Colors.grey,
    child: TabBar(
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white70,
      indicatorSize: TabBarIndicatorSize.tab,
      indicatorPadding: EdgeInsets.all(5.0),
      indicatorColor: Colors.grey,
      tabs: [
        Tab(
          text: "Transactions",
          icon: Icon(Icons.book),
        ),
        Tab(
          text: "Trends",
          icon: Icon(Icons.query_stats_sharp),
        ),
        Tab(
          text: "Balance",
          icon: Icon(Icons.account_balance_wallet),
        ),
        Tab(
          text: "Options",
          icon: Icon(Icons.settings),
        ),
      ],
    ),
  );
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Colors.amber,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Image.asset('assets/images/stonks.png'),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: _incrementCounter,
        tooltip: 'Add new item',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
