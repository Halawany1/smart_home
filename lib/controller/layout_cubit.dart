import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:bloc/bloc.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:smart_home/core/notifications.dart';
import 'package:smart_home/model/data_model.dart';
import 'package:smart_home/views/analysis_screen/analysis_screen.dart';
import 'package:smart_home/views/home_screen/home_screen.dart';

part 'layout_state.dart';

class LayoutCubit extends Cubit<LayoutState> {
  LayoutCubit() : super(LayoutInitial());


  static LayoutCubit get(context) => BlocProvider.of(context);

  int index = 0;
  List<Widget> screens=const [
    HomeScreen(),
    AnalysisScreen()
  ];
  DataModel? dataModel;
  void changeIndex(int index) {
    this.index = index;
    emit(LayoutInitial());
  }
  DatabaseReference dbRef = FirebaseDatabase.instance.reference();
  void getData() {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    ref.onValue.listen((DatabaseEvent event) {
      var data = event.snapshot.value as dynamic;
      if (data != null) {
        dynamic temp = data['temperature'];
        bool? motion = data['motion'];
        dynamic gas = data['gas'];
        dynamic pir = data['pir'];
        bool? buzzer = data['buzzer'];
        dynamic humidity = data['humidity'];
        dynamic flame = data['flame'];
        dynamic waterLevel = data['water_level'];
        if(motion == true){
          LocalNotificationService().showNotificationAndroid("Motion Detected", "Motion Detected");
        }
        else if(buzzer == true){
          LocalNotificationService().showNotificationAndroid("Buzzer Detected", "Buzzer Detected");
        }

        // Create an instance of DataModel
        dataModel = DataModel(
          temp: temp,
          motion: motion,
          gas: gas,
          pir: pir,
          buzzer: buzzer,
          humidity: humidity,
          flame: flame,
          waterLevel: waterLevel,
        );
        print(dataModel!.temp);

        emit(SuccessGetData());
      }
    });
  }

  void updateBuzzerValue(bool newValue) {
    DatabaseReference ref = FirebaseDatabase.instance.ref();
    ref.update({'Buzzer': newValue}).then((_) {
      emit(SuccessUpdateBuzzerState());
    }).catchError((error) {
      emit(FailedUpdateBuzzerState());
    });
  }
}
