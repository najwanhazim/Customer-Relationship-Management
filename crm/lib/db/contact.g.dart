// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'contact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Contact _$ContactFromJson(Map<String, dynamic> json) => Contact(
      fullname: json['fullname'] as String,
      position: json['position'] as String,
      phone_no: json['phone_no'] as String,
      email: json['email'] as String,
      salutation: json['salutation'] as String,
      contact_type: json['contact_type'] as String,
      source: json['source'] as String,
    );

Map<String, dynamic> _$ContactToJson(Contact instance) => <String, dynamic>{
      'fullname': instance.fullname,
      'position': instance.position,
      'phone_no': instance.phone_no,
      'email': instance.email,
      'salutation': instance.salutation,
      'contact_type': instance.contact_type,
      'source': instance.source,
    };
