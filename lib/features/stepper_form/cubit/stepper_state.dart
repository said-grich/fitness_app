// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'stepper_cubit.dart';

enum StepperStatus { initial, submitting ,succes, error }

class StepperState extends Equatable {
  final int currentStep;
  final String errorMsgName;
  final String errorMsgRole;
  final String errorMsgSex;
  final String errorMsgAge;
  final String errorMsgLength;
  final String errorMsgPoids;
  final String errorMsgPhone;
  final StepperStatus status;
  final String fullname;
  final String sex;
  final String role;
  final String age;
  final String length;
  final String poids;
  final String phone;
  final String photoUrl;
  const StepperState({required this.fullname, required this.sex,required this.role,required this.age,required this.length,required this.poids,required this.phone, 
      required this.errorMsgRole,
      required this.errorMsgSex,
      required this.errorMsgAge,
      required this.errorMsgLength,
      required this.errorMsgPoids,
      required this.errorMsgPhone,
      required this.currentStep,
      required this.errorMsgName,
      required this.photoUrl,
      required this.status});
  factory StepperState.initial() {
    return const StepperState(
        currentStep: 0,
        errorMsgAge: '',
        errorMsgLength: '',
        errorMsgPhone: '',
        errorMsgRole: '',
        errorMsgSex: '',
        errorMsgName: '',
        status: StepperStatus.initial,
        errorMsgPoids: '', age: '', fullname: '', length: '', phone: '', poids: '', role: '', sex: '', photoUrl: '',
        
        
        
        );
  }

  @override
  List<Object> get props => [currentStep,photoUrl,errorMsgLength,errorMsgPhone,errorMsgRole,errorMsgSex,poids,length,errorMsgPoids,errorMsgLength ,errorMsgPoids,errorMsgName,age ,fullname, status];



  StepperState copyWith({
    int? currentStep,
    String? errorMsgName,
    String? errorMsgRole,
    String? errorMsgSex,
    String? errorMsgAge,
    String? errorMsgLength,
    String? errorMsgPoids,
    String? errorMsgPhone,
    StepperStatus? status,
    String? fullname,
    String? sex,
    String? role,
    String? age,
    String? length,
    String? poids,
    String? phone,
    String? photoUrl,
  }) {
    return StepperState(
      currentStep: currentStep ?? this.currentStep,
      errorMsgName: errorMsgName ?? this.errorMsgName,
      errorMsgRole: errorMsgRole ?? this.errorMsgRole,
      errorMsgSex: errorMsgSex ?? this.errorMsgSex,
      errorMsgAge: errorMsgAge ?? this.errorMsgAge,
      errorMsgLength: errorMsgLength ?? this.errorMsgLength,
      errorMsgPoids: errorMsgPoids ?? this.errorMsgPoids,
      errorMsgPhone: errorMsgPhone ?? this.errorMsgPhone,
      status: status ?? this.status,
      fullname: fullname ?? this.fullname,
      sex: sex ?? this.sex,
      role: role ?? this.role,
      age: age ?? this.age,
      length: length ?? this.length,
      poids: poids ?? this.poids,
      phone: phone ?? this.phone,
      photoUrl: photoUrl ?? this.photoUrl,
    );
  }
}
