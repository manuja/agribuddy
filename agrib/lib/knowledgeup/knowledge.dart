class Knowledge {

  int _id;
  String _title;
  String _description;
  String _author;
  String _date;

  Knowledge(this._title,this._description, this._author, this._date);

  Knowledge.withId(this._id, this._title, this._description, this._author, this._date);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  String get author => _author;

  String get date => _date;


  set title(String newTitle) {
    if (newTitle.length <= 255) {
      this._title = newTitle;
    }
  }
  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }


  set author(String newAuthor) {
    if (newAuthor.length <= 255) {
      this._author= newAuthor;
    }
  }

  set date(String newDate) {
    this._date = newDate;
  }

  // set priority(int newPriority) {
  //   this._priority = newPriority;
  // }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }
    map['title'] = _title;
    map['description'] = _description;
    map['date'] = _date;
    map['author'] = _author;

    return map;
  }

  // Extract a Note object from a Map object
  Knowledge.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
    this._author= map['author'];
  }
}


