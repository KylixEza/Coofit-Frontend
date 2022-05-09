import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

}

class SearchState extends State<SearchPage> {

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
    return Container(
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
    );
  }

}