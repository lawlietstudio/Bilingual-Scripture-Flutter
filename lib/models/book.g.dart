// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'book.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Book _$BookFromJson(Map<String, dynamic> json) => Book(
      book: MultilingualText.fromJson(json['book'] as Map<String, dynamic>),
      theme: MultilingualText.fromJson(json['theme'] as Map<String, dynamic>),
      introduction: MultilingualText.fromJson(
          json['introduction'] as Map<String, dynamic>),
      chapters: (json['chapters'] as List<dynamic>)
          .map((e) => Chapter.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BookToJson(Book instance) => <String, dynamic>{
      'book': instance.book,
      'theme': instance.theme,
      'introduction': instance.introduction,
      'chapters': instance.chapters,
    };

Chapter _$ChapterFromJson(Map<String, dynamic> json) => Chapter(
      number: json['number'] as int,
      introduction: MultilingualText.fromJson(
          json['introduction'] as Map<String, dynamic>),
      verses: (json['verses'] as List<dynamic>)
          .map((e) => Verse.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ChapterToJson(Chapter instance) => <String, dynamic>{
      'number': instance.number,
      'introduction': instance.introduction,
      'verses': instance.verses,
    };

Verse _$VerseFromJson(Map<String, dynamic> json) => Verse(
      key: json['key'] as String,
      text: MultilingualText.fromJson(json['text'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$VerseToJson(Verse instance) => <String, dynamic>{
      'key': instance.key,
      'text': instance.text,
    };

MultilingualText _$MultilingualTextFromJson(Map<String, dynamic> json) =>
    MultilingualText(
      en: json['en'] as String,
      zh: json['zh'] as String,
    );

Map<String, dynamic> _$MultilingualTextToJson(MultilingualText instance) =>
    <String, dynamic>{
      'en': instance.en,
      'zh': instance.zh,
    };
