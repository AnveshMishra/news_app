import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_project/value/colors.dart';
import 'package:news_project/view_models/source_list_view_model.dart';

import '../../view_models/news_article_list_view_model.dart';

class FilterBottomSheet extends StatefulWidget {
  final SourceListViewModel source;
  final NewsArticleListViewModel newsArticleVm;

  const FilterBottomSheet(
      {Key? key, required this.source, required this.newsArticleVm})
      : super(key: key);

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  @override
  Widget build(BuildContext context) {
    var textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        const SizedBox(
          height: 4,
        ),
        Container(
          width: 36,
          height: 4,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey.shade400),
        ),
        const SizedBox(
          height: 16,
        ),
        Align(
          alignment: Alignment.bottomLeft,
          child: Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
              "Filter by sources",
              style: textTheme.headline1
                  ?.copyWith(color: Colors.grey.shade800, fontSize: 18),
            ),
          ),
        ),
        Divider(
          endIndent: 16,
          indent: 16,
          color: Colors.grey.shade300,
          thickness: 1.5,
        ),
        Expanded(
          child: SizedBox(
            child: ListView.builder(
              itemBuilder: (_, index) {
                var sourceVm = widget.source.source[index];
                return Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(sourceVm.name, style: textTheme.headline2?.copyWith(
                        color: widget.newsArticleVm.selectedSource
                            .contains(sourceVm.id)
                            ? Colors.blue: Colors.grey.shade500
                      )),
                      Checkbox(
                        value: widget.newsArticleVm.selectedSource
                            .contains(sourceVm.id),
                        onChanged: (value) {
                          widget.newsArticleVm.addOrRemoveSources(sourceVm.id ?? "");
                          setState(() {});
                        },
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(4)),
                        checkColor: Colors.blueAccent,
                        side: MaterialStateBorderSide.resolveWith((_) =>
                            BorderSide(
                                width: 1,
                                color: widget.newsArticleVm.selectedSource
                                        .contains(sourceVm.id)
                                    ? Colors.blue
                                    : HexColor("#CED3DC"))),
                      ),
                    ],
                  ),
                );
              },
              itemCount: widget.source.source.length,
            ),
          ),
        ),
        MaterialButton(
          onPressed: () {
            Navigator.pop(context);
            widget.newsArticleVm.fetchFilteredData();
          },
          color: AppColors.appBlueColor,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Apply Filter",
              style: textTheme.headline1?.copyWith(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 16,),
      ],
    );
  }
}
