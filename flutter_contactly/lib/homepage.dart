import 'package:flutter/material.dart';
import 'helpers/constants.dart';
import 'models/records.dart';
import 'models/recordslist.dart';
import 'models/recordservice.dart';
import 'detailspage.dart';

//Called and used when navigating to and presenting the page
class HomePage extends StatefulWidget {

  @override
  _HomePageState createState(){
    return _HomePageState();
  }
}

//Private class called each time HomePage is called
class _HomePageState extends State<HomePage>{
  //Allows for a listener on the search
  final TextEditingController _filter = new TextEditingController();

  //State of our original and filtered records
  RecordList _records = new RecordList();
  RecordList _filteredRecords = new RecordList();

  String _searchText = "";
  Icon _searchIcon = new Icon(Icons.search);

  Widget _appBarTitle = new Text(appTitle);

  @override
  void initState(){
    super.initState();
    //We are going to refresh our records to get a fresh state from the file
    _records.records = new List();
    _filteredRecords.records = new List();

    _getRecords();
  }

  //This is async but it doesn't really need to be as it is a local file
  void _getRecords() async{
    RecordList records = await RecordService().loadRecords();
    setState((){
      for (Record record in records.records){
        this._records.records.add(record);
        this._filteredRecords.records.add(record);
      }
    });
  }

  //We need to return a scaffold for the UI structure
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: _buildBar(context),
      backgroundColor: appDarkGreyColor,
      body: _buildList(context),
      resizeToAvoidBottomPadding: false,
    );
  }

  Widget _buildBar(BuildContext context){
    return new AppBar(
      elevation: 0.1,
      backgroundColor: appDarkGreyColor,
      centerTitle: true,
      title: _appBarTitle,
      leading: new IconButton(
        icon: _searchIcon,
        onPressed: _searchPressed,
      ),
    );
  }

  Widget _buildList(BuildContext context){
    if (!(_searchText.isEmpty)) {
      _filteredRecords.records = new List();
      for (int i = 0; i < _records.records.length; i++) {
        if (_records.records[i].name.toLowerCase().contains(_searchText.toLowerCase())
            || _records.records[i].address.toLowerCase().contains(_searchText.toLowerCase())) {
          _filteredRecords.records.add(_records.records[i]);
        }
      }
    }

    return ListView(
      padding: const EdgeInsets.only(top: 20.0),
      children: this._filteredRecords.records.map((data) => _buildListItem(context, data)).toList()
    );
  }

  Widget _buildListItem(BuildContext context, Record record) {
    //In each card we have a ListTile with a leading avatar
    //A title, subtitle (wrapped in flexible for growing texts and an arrow
    return Card(
      key: ValueKey(record.name),
      elevation: 8.0,
      margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
      child: Container(
        decoration: BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
        child: ListTile(
          contentPadding:
          EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
          leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.white24))),
              child: Hero(
                  tag: "avatar_" + record.name,
                  child: CircleAvatar(
                    radius: 32,
                    backgroundImage: NetworkImage(record.photo),
                  )
              )
          ),
          title: Text(
            record.name,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: <Widget>[
              new Flexible(
                  child: new Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        RichText(
                          text: TextSpan(
                            text: record.address,
                            style: TextStyle(color: Colors.white),
                          ),
                          maxLines: 3,
                          softWrap: true,
                        )
                      ]))
            ],
          ),
          trailing:
          Icon(Icons.keyboard_arrow_right, color: Colors.white, size: 30.0),
          onTap: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => new DetailPage(record: record)));
          },
        ),
      ),
    );
  }

  _HomePageState() {
    _filter.addListener(() {
      if (_filter.text.isEmpty) {
        setState(() {
          _searchText = "";
          _resetRecords();
        });
      } else {
        setState(() {
          _searchText = _filter.text;
        });
      }
    });
  }

  void _resetRecords(){
    this._filteredRecords.records = new List();
    for (Record record in _records.records){
      this._filteredRecords.records.add(record);
    }
  }

  void _searchPressed(){
    setState((){
      if (this._searchIcon.icon == Icons.search){
        this._searchIcon = new Icon(Icons.close);
        this._appBarTitle = new TextField(
          controller: _filter,
          style: new TextStyle(color: Colors.white),
          decoration: new InputDecoration(
            prefixIcon: new Icon(Icons.search, color: Colors.white),
            fillColor: Colors.white,
            hintText: 'Search by Name',
            hintStyle: TextStyle(color: Colors.white),
          )
        );
      }
      else{
        this._searchIcon = new Icon(Icons.search);
        this._appBarTitle = new Text(appTitle);
        _filter.clear();
      }
    });
  }
}