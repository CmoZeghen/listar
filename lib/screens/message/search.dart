import 'dart:async';

import 'package:flutter/material.dart';

import 'result.dart';
import 'suggestion.dart';

class MessageSearchDelegate extends SearchDelegate {
  Timer? timer;

  MessageSearchDelegate();

  void onSearch() {
    timer?.cancel();
    timer = Timer(const Duration(milliseconds: 500), () {});
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    onSearch();
    return SuggestionSearchList(query: query);
  }

  @override
  Widget buildResults(BuildContext context) {
    return ResultSearchList(query: query);
  }

  @override
  List<Widget>? buildActions(BuildContext context) {
    if (query.isNotEmpty) {
      return <Widget>[
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            showSuggestions(context);
          },
        )
      ];
    }
    return null;
  }
}
