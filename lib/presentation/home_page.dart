import 'package:coofit/presentation/prediction_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  static const routeName = '/home_page';

  @override
  State<StatefulWidget> createState() => _HomePageState();

}
class _HomePageState extends State<HomePage> {

  String query = '';
  late TextEditingController _searchController;

  @override
  void initState() {
    _searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Coofit"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, PredictionPage.routeName);
            },
            icon: const Icon(Icons.fastfood),
            padding: const EdgeInsets.symmetric(horizontal: 16.0)
          ),
          IconButton(onPressed: () {}, icon: const Icon(Icons.favorite), padding: const EdgeInsets.symmetric(horizontal: 16.0)),
          IconButton(onPressed: () {}, icon: const Icon(Icons.person), padding: const EdgeInsets.symmetric(horizontal: 16.0))
        ],
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 48.0),
        child: Column(
          children: [
            TextField(
              controller: _searchController,
              keyboardType: TextInputType.text,
              decoration: InputDecoration(
                labelText: 'Find your favorite restaurant or menu',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              onChanged: (String s) {
                setState(() {
                  query = s;
                  //value.fetchAllSearchRestaurant(query);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}