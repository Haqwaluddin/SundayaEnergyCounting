class ChintDevices {

  String timeStamp;
  String energyA;
  String energyB;
  String energyC;


  ChintDevices({this.timeStamp,this.energyA,this.energyB,this.energyC});

  factory ChintDevices.createData(Map<String,dynamic>object){

    return ChintDevices(
      timeStamp:object['time_stamp'],
      energyA: object['energy_a'],
      energyB: object['energy_b'],
      energyC: object['energy_c'],

    );


  }
  
}