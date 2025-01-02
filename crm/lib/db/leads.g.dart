// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'leads.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Leads _$LeadsFromJson(Map<String, dynamic> json) => Leads(
      portfolio: json['portfolio'] as String,
      title: json['title'] as String,
      scope: json['scope'] as String,
      client: json['client'] as String,
      end_user: json['end_user'] as String,
      location: json['location'] as String,
      status: json['status'] as String,
      value: (json['value'] as num).toDouble(),
    );

Map<String, dynamic> _$LeadsToJson(Leads instance) => <String, dynamic>{
      'portfolio': instance.portfolio,
      'title': instance.title,
      'scope': instance.scope,
      'client': instance.client,
      'end_user': instance.end_user,
      'location': instance.location,
      'status': instance.status,
      'value': instance.value,
    };
