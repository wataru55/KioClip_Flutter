// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ogp.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Ogp {

// OGPのタイトル
 String get title;// OGPの画像URL
 String? get imageUrl;
/// Create a copy of Ogp
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OgpCopyWith<Ogp> get copyWith => _$OgpCopyWithImpl<Ogp>(this as Ogp, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Ogp&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,title,imageUrl);

@override
String toString() {
  return 'Ogp(title: $title, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class $OgpCopyWith<$Res>  {
  factory $OgpCopyWith(Ogp value, $Res Function(Ogp) _then) = _$OgpCopyWithImpl;
@useResult
$Res call({
 String title, String? imageUrl
});




}
/// @nodoc
class _$OgpCopyWithImpl<$Res>
    implements $OgpCopyWith<$Res> {
  _$OgpCopyWithImpl(this._self, this._then);

  final Ogp _self;
  final $Res Function(Ogp) _then;

/// Create a copy of Ogp
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? title = null,Object? imageUrl = freezed,}) {
  return _then(_self.copyWith(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Ogp].
extension OgpPatterns on Ogp {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Ogp value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Ogp() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Ogp value)  $default,){
final _that = this;
switch (_that) {
case _Ogp():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Ogp value)?  $default,){
final _that = this;
switch (_that) {
case _Ogp() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String title,  String? imageUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Ogp() when $default != null:
return $default(_that.title,_that.imageUrl);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String title,  String? imageUrl)  $default,) {final _that = this;
switch (_that) {
case _Ogp():
return $default(_that.title,_that.imageUrl);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String title,  String? imageUrl)?  $default,) {final _that = this;
switch (_that) {
case _Ogp() when $default != null:
return $default(_that.title,_that.imageUrl);case _:
  return null;

}
}

}

/// @nodoc


class _Ogp implements Ogp {
  const _Ogp({required this.title, this.imageUrl});
  

// OGPのタイトル
@override final  String title;
// OGPの画像URL
@override final  String? imageUrl;

/// Create a copy of Ogp
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OgpCopyWith<_Ogp> get copyWith => __$OgpCopyWithImpl<_Ogp>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Ogp&&(identical(other.title, title) || other.title == title)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl));
}


@override
int get hashCode => Object.hash(runtimeType,title,imageUrl);

@override
String toString() {
  return 'Ogp(title: $title, imageUrl: $imageUrl)';
}


}

/// @nodoc
abstract mixin class _$OgpCopyWith<$Res> implements $OgpCopyWith<$Res> {
  factory _$OgpCopyWith(_Ogp value, $Res Function(_Ogp) _then) = __$OgpCopyWithImpl;
@override @useResult
$Res call({
 String title, String? imageUrl
});




}
/// @nodoc
class __$OgpCopyWithImpl<$Res>
    implements _$OgpCopyWith<$Res> {
  __$OgpCopyWithImpl(this._self, this._then);

  final _Ogp _self;
  final $Res Function(_Ogp) _then;

/// Create a copy of Ogp
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? title = null,Object? imageUrl = freezed,}) {
  return _then(_Ogp(
title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
