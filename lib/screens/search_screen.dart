// ignore_for_file: prefer_const_constructors, unnecessary_null_comparison

import 'package:d_o_cakes/models/cake_model.dart';
import 'package:d_o_cakes/provider/cakes_provider.dart';
import 'package:d_o_cakes/widgets/home_cakes.dart';
import 'package:d_o_cakes/widgets/searchby_header.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  static const routeName = '/SearchScreen';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  TextEditingController? _searchTextController;
  final FocusNode _node = FocusNode();

  @override
  void initState() {
    super.initState();
    _searchTextController = TextEditingController();
    _searchTextController!.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    super.dispose();
    _node.dispose();
    _searchTextController!.dispose();
  }

  List<Cake> _searchList = [];

  @override
  Widget build(BuildContext context) {
    final cakeData = Provider.of<Cakes>(context);
    final cakeList = cakeData.cakes;
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            floating: true,
            pinned: true,
            delegate: SearchByHeader(
              stackPaddingTop: 175,
              titlePaddingTop: 50,
              title: Text(
                'Search',
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 25.0,
                ),
              ),
              stackChild: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(
                    Radius.circular(10),
                  ),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black12,
                      spreadRadius: 1,
                      blurRadius: 3,
                    ),
                  ],
                ),
                margin: EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  controller: _searchTextController,
                  minLines: 1,
                  focusNode: _node,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(width: 0, style: BorderStyle.none),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                    ),
                    hintText: 'Search',
                    filled: true,
                    fillColor: Theme.of(context).cardColor,
                    suffixIcon: IconButton(
                      onPressed: _searchTextController!.text.isEmpty
                          ? null
                          : () {
                              _searchTextController!.clear();
                              _node.unfocus();
                            },
                      icon: Icon(Icons.close,
                          color: _searchTextController!.text.isNotEmpty
                              ? Colors.red
                              : Colors.grey),
                    ),
                  ),
                  onChanged: (value) {
                    _searchTextController!.text.toLowerCase();
                    setState(() {
                      _searchList = cakeData.searchQuery(value);
                    });
                  },
                ),
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _searchTextController!.text.isNotEmpty && _searchList.isEmpty
                ? Center(
                    child: Text(
                      'No result found!',
                    ),
                  )
                : GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    childAspectRatio: 190 / 265,
                    crossAxisSpacing: 2,
                    mainAxisSpacing: 2,
                    children: List.generate(
                      _searchTextController!.text.isEmpty
                          ? cakeList.length
                          : _searchList.length,
                      (index) {
                        return ChangeNotifierProvider.value(
                          value: _searchTextController!.text.isEmpty
                              ? cakeList[index]
                              : _searchList[index],
                          child: HomeCakes(),
                        );
                      },
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
