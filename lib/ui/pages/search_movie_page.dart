import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../../providers/audiovisuales_provider.dart';
import '..//widgets/audiovisual_list.dart';
import '..//widgets/hex_color.dart';

enum ShowOptions { Grid, List }

class SearchScreen extends StatefulWidget {
  static const routeName = '/search';

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin {
  var _isLoading = false;
  final _types = [
    //movie, series, episode
    {'label': 'Películas', 'value': 'movie'},
    {'label': 'Series', 'value': 'series'},
    {'label': 'Todos', 'value': ''}
  ];
  String _type = '';
  String _query = '';

  AudiovisualListProvider provider;
  final _controller = TextEditingController();
  Timer _debounce;
  final _searchFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _controller.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _controller.dispose();
    _controller.removeListener(_onSearchChanged);
    _debounce.cancel();
    super.dispose();
  }

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (_controller.text.isEmpty) {
        provider.clearList();
        _searchFocusNode.requestFocus();
      }
      else if (_query != _controller.text) {
        _query = _controller.text;
        makeSearch();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    provider =
        Provider.of<AudiovisualListProvider>(context, listen: false);
    final appBarChild = getAppBarChild(provider, context);
    return Scaffold(
        body: CustomScrollView(
      slivers: <Widget>[
        SliverAppBar(
          titleSpacing: 0,
          elevation: 10,
          backgroundColor: Colors.white,
          title: appBarChild,
          pinned: false,
          floating: true,
          primary: true,
          bottom: PreferredSize(
              child: Divider(
                indent: 10,
                endIndent: 10,
                height: 3,
                thickness: 1,
              ),
              preferredSize: Size.fromHeight(3)),
        ),
        /*_isLoading
            ? Center(child: CircularProgressIndicator())
            : */
        Consumer<AudiovisualListProvider>(
            builder: (ctx, provider, child) => provider.loading
                ? SliverFillRemaining(
                    child: Center(
                    child: CircularProgressIndicator(),
                  ))
                : provider.items != null && provider.items.length > 0
                    ? AudiovisualList(
                        sliverList: true,
                      )
                    : SliverFillRemaining(
                        child: AudiovisualList(),
                        hasScrollBody: false,
                      )),
      ],
    ));
  }

  Widget getAppBarChild(
      AudiovisualListProvider provider, BuildContext context) {
    return Container(
      color: Colors.transparent,
      padding: const EdgeInsets.all(20),
      child: Row(
        children: <Widget>[
          Expanded(
            child: CupertinoTextField(
              controller: _controller,
              focusNode: _searchFocusNode,
              textInputAction: TextInputAction.search,
              onSubmitted: (text) {
                _query = text;
                makeSearch();
              },
              clearButtonMode: OverlayVisibilityMode.editing,
              placeholder: 'ej: Back to the Future...',
              placeholderStyle:
                  TextStyle(color: Colors.black38, fontStyle: FontStyle.italic),
              prefix: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Icon(
                  Icons.search,
                  color: HexColor('#252525'),
                ),
              ),
              prefixMode: OverlayVisibilityMode.notEditing,
              style: ThemeData.dark()
                  .textTheme
                  .title
                  .copyWith(color: HexColor('#252525')),
              maxLength: 50,
              decoration: BoxDecoration(
                color: Colors.transparent, //HexColor('#252525'),
//                    borderRadius: BorderRadiusDirectional.circular(10),
              ),
            ),
          ),
          PopupMenuButton(
            onSelected: (String selectedValue) {
              setState(() {
                _type = selectedValue;
              });
              makeSearch();
            },
            initialValue: _type,
            tooltip: 'Filtros',
            color: Colors.white,
            icon: Icon(
              FontAwesomeIcons.filter,
              color: _type.isEmpty
                  ? HexColor('#252525')
                  : Theme.of(context).primaryColor,
              size: 18,
            ),
            itemBuilder: (_) => _types
                .map((type) => PopupMenuItem(
                      value: type['value'],
                      child: Text(type['label']),
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }

  void makeSearch() {
    if (_query != null && _query.isNotEmpty && _query.length > 2) {
      setState(() {
        _isLoading = true;
      });
      provider.search(context, _query, type: _type).then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
  }

  @override
  bool get wantKeepAlive => true;
}
