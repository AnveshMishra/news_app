
import 'package:flutter/material.dart';
import '../../value/colors.dart';
import '../../value/country_data.dart';
import '../../view_models/news_article_list_view_model.dart';

class CountryBottomSheet extends StatefulWidget {
  final NewsArticleListViewModel newsArticleVm;
  const CountryBottomSheet({Key? key, required this.newsArticleVm}) : super(key: key);

  @override
  State<CountryBottomSheet> createState() => _CountryBottomSheetState();
}

class _CountryBottomSheetState extends State<CountryBottomSheet> {
  late String selected;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     selected = widget.newsArticleVm.selectedLocation.isoCountryCode;
  }
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
              "Choose your location",
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
                var countryModel = country[index];
                return Container(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(countryModel.name,
                          style: textTheme.headline2?.copyWith(
                          color: widget.newsArticleVm.selectedLocation.name == countryModel.name
                              ? Colors.blue: Colors.grey.shade500
                      )),
                      Radio(value:countryModel.isoCountryCode
                          , groupValue: selected, onChanged: (value){
                            selected = countryModel.isoCountryCode;
                            widget.newsArticleVm.selectedLocation = countryModel;
                            setState(() {
                            });
                          })
                    ],
                  ),
                );
              },
              itemCount: country.length,
            ),
          ),
        ),
        MaterialButton(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8)
          ),
          onPressed: () {
            Navigator.pop(context);
            widget.newsArticleVm.fetchDataBasedOnLocation();
          },
          color: AppColors.appBlueColor,
          child: Padding(
            padding: const EdgeInsets.only(left: 24,right: 24,bottom: 8,top: 8),
            child: Text(
              "Apply",
              style: textTheme.headline1?.copyWith(color: Colors.white),
            ),
          ),
        ),
        const SizedBox(height: 16,),
      ],
    );
  }
}
