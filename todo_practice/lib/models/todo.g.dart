// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
  done: json['done'] as bool,
  task: json['task'] as String,
  dueDate: DateTime.parse(json['dueDate'] as String),
);

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) =>
    <String, dynamic>{
      'done': instance.done,
      'task': instance.task,
      'dueDate': instance.dueDate.toIso8601String(),
    };
