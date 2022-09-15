class BestFit {

  int _id;
  String _maincrop;
  String _landscape;
  String _soil;
  String _rain;
  String _crop;
  int _title;
  String _description;



  BestFit(this._maincrop,this._landscape,this._soil,this._rain,this._title, this._crop, this._description);

  BestFit.withId(this._id, this._maincrop, this._landscape,this._soil,this._rain, this._title, this._crop, this._description);

  int get id => _id;

  String get maincrop => _maincrop;

  String get landscape => _landscape;

  String get soil => _soil;

  String get rain => _rain;

  String get crop => _crop;

  int get title => _title; //temp

  String get description => _description;

  //int get priority => _priority;

  //String get date => _date;

  set maincrop(String newMainCrop) {
    if (newMainCrop.length <= 255) {
      this._maincrop = newMainCrop;
    }
  }

  set landscape(String newLandScape) {
    if (newLandScape.length <= 255) {
      this._landscape = newLandScape;
    }
  }

  set soil(String newSoil) {
    if (newSoil.length <= 255) {
      this._soil = newSoil;
    }
  }

  set rain(String newRain) {
    if (newRain.length <= 255) {
      this._rain = newRain;
    }
  }

  set crop(String newCrop) {
    if (newCrop.length <= 255) {
      this._crop = newCrop;
    }
  }

  set title(int newTitle) {
      this._title = newTitle;
  }
  set description(String newDescription) {
    if (newDescription.length <= 255) {
      this._description = newDescription;
    }
  }

  // set date(String newDate) {
  //   this._date = newDate;
  // }
  //
  // set priority(int newPriority) {
  //   this._priority = newPriority;
  // }

  // Convert a Note object into a Map object
  Map<String, dynamic> toMap() {

    var map = Map<String, dynamic>();
    if (id != null) {
      map['id'] = _id;
    }

    map['maincrop'] = _maincrop;
    map['landscape'] = _landscape;
    map['crop'] = _crop;
    map['title'] = _title;
    map['description'] = _description;
    map['soil'] = _soil;
    map['rain'] = _rain;
    //map['date'] = _date;
   // map['priority'] = _priority;

    return map;
  }

  // Extract a Note object from a Map object
  BestFit.fromMapObject(Map<String, dynamic> map) {
    this._id = map['id'];
    this._maincrop = map['maincrop'];
    this._landscape = map['landscape'];
    this._crop = map['crop'];
    this._title = map['title'];
    this._description = map['description'];
    this._soil = map['soil'];
    this._rain = map['rain'];
    //this._date = map['date'];
    //this._priority= map['priority'];
  }
}


