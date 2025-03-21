import 'dart:convert';

import 'package:cargofl_assignment/model/dog_data_model.dart';
import 'package:cargofl_assignment/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class DogDataProvider extends ChangeNotifier {
  final ScrollController scrollController = ScrollController();
  bool _isLoading = false;
  bool _isMoreData = true;
  int _page = 0;

  bool get isLoading => _isLoading;
  bool get isMoreData => _isMoreData;
  List<DogDataModel> get dogData => _dogData;
  List<DogDataModel> _dogData = [];

  Future<void> getDogData({needLoading, required BuildContext context}) async {
    if (needLoading) {
      _isLoading = true;
    }
    int limit = 10;
    try {
      final response = await http.get(Uri.parse(
          'https://api.thedogapi.com/v1/images/search?limit=$limit&page=$_page&order=Desc'));

      if (response.statusCode == 200) {
        List<dynamic> newData = jsonDecode(response.body);

        _page++;
        print(_page);
        _isLoading = true;
        print(_page);
        if (newData.isEmpty) {
          _isMoreData = false;
        }
        _dogData.addAll(
            newData.map((item) => DogDataModel.fromJson(item)).toList());

        notifyListeners();
      }
    } catch (e) {
      Utils.flushBarErrorMessage(e.toString(), context);
    } finally {
      _isLoading = false;
    }
  }

  String defaultCategory = 'All';
  List<Map<String, dynamic>> category = [
    {'name': "All"},
    {'name': "Affenpinscher"},
    {'name': "Bull Dog"},
    {'name': "Airedale Terrier"},
    {'name': "Akita"},
    {'name': "Pitbull Terrier"},
  ];
  void categoryToggle(String categ) {
    defaultCategory = defaultCategory = categ;
    notifyListeners();
  }
}
