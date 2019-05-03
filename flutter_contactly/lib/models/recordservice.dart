import 'recordslist.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

class RecordService {
  //Future is the result of an asynchronous object
  Future<String> _loadRecordsAsset() async{
    return await rootBundle.loadString('assets/data/records.json');
  }

  Future<RecordList> loadRecords() async {
    //Wait for this to come in
    String jsonString = await _loadRecordsAsset();
    //Decode the JSON into an object
    final jsonResponse = json.decode(jsonString);
    //Format as we have done in our models
    RecordList records = new RecordList.fromJson(jsonResponse);
    //Return the nicely formatted data
    return records;
  }
}