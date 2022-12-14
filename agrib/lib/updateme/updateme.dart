class UpdateMe {

  int _id;
  String _title;
  String _description;
  String _date;
  //int _priority;

  UpdateMe(this._title, this._description, this._date);

  UpdateMe.withId(this._id, this._title, this._description , this._date);

  int get id => _id;

  String get title => _title;

  String get description => _description;

  //int get priority => _priority;

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
    //map['priority'] = _priority;

    return map;
  }

  // Extract a Note object from a Map object
  UpdateMe.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._title = map['title'];
    this._description = map['description'];
    this._date = map['date'];
   // this._priority= map['priority'];
  }
}


