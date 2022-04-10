import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_project/view_models/search_view_model.dart';
import 'package:provider/provider.dart';

import '../search_screen.dart';

class SearchBar extends StatelessWidget {
  final bool isSearchReadOnly;
  final Function(String)? onChangedCallBack;

  const SearchBar({Key? key, this.isSearchReadOnly = false, this.onChangedCallBack}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
          color: HexColor("#CED3DC"), borderRadius: BorderRadius.circular(8)),
      child: TextField(
        onChanged: (String value){
          if(onChangedCallBack!=null){
            onChangedCallBack!(value);
          }
        },
        onTap: () {
          if (isSearchReadOnly) {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProvider(
                        create: (context) => SearchViewModel(),
                      child: const SearchScreen(),
                    )));
          }
        },
        readOnly: isSearchReadOnly,
        decoration: InputDecoration(
          prefix: const SizedBox(
            width: 16,
          ),
          hintText: "Search for news topic...",
          suffixIconConstraints:
              const BoxConstraints(maxHeight: 36, maxWidth: 36),
          suffixIcon: Container(
            margin: const EdgeInsets.only(right: 16),
            height: 36,
            width: 36,
            child: Image.asset(
              "assets/icons/search.png",
              height: 8,
              width: 8,
            ),
          ),
          hintStyle: const TextStyle(
            color: Colors.black54,
            fontFamily: "HelveticaNeueLight",
            fontWeight: FontWeight.w500,
            letterSpacing: 1,
            fontSize: 12,
          ),
          border: InputBorder.none,
          // isCollapsed: true,
        ),
      ),
    );
  }
}
