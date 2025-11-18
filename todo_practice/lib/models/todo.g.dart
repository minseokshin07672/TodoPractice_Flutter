// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TodoImpl _$$TodoImplFromJson(Map<String, dynamic> json) => _$TodoImpl(
  status: $enumDecode(_$TodoStatusEnumMap, json['status']),
  task: json['task'] as String,
  dueDate: DateTime.parse(json['dueDate'] as String),
);

Map<String, dynamic> _$$TodoImplToJson(_$TodoImpl instance) =>
    <String, dynamic>{
      'status': _$TodoStatusEnumMap[instance.status]!,
      'task': instance.task,
      'dueDate': instance.dueDate.toIso8601String(),
    };

const _$TodoStatusEnumMap = {TodoStatus.todo: 'todo', TodoStatus.done: 'done'};
