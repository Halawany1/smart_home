class DataModel {
  dynamic temp;
  bool? motion;
  dynamic gas;
  dynamic pir;
  dynamic temperature;
  bool? buzzer;
  dynamic humidity;
  dynamic flame;
  dynamic waterLevel;

  DataModel(
      {this.temp,
        this.motion,
        this.gas,
        this.pir,
        this.temperature,
        this.buzzer,
        this.humidity,
        this.flame,
        this.waterLevel});

  DataModel.fromJson(Map<String, dynamic> json) {
    temp = json['temp'];
    motion = json['motion'];
    gas = json['gas'];
    pir = json['pir'];
    temperature = json['temperature'];
    buzzer = json['Buzzer'];
    humidity = json['humidity'];
    flame = json['flame'];
    waterLevel = json['water_level'];
  }


}