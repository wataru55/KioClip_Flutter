// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ogp.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$Ogp {
  // OGPのタイトル
  String get title => throw _privateConstructorUsedError; // OGPの画像URL
  String? get imageUrl => throw _privateConstructorUsedError;

  /// Create a copy of Ogp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OgpCopyWith<Ogp> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OgpCopyWith<$Res> {
  factory $OgpCopyWith(Ogp value, $Res Function(Ogp) then) =
      _$OgpCopyWithImpl<$Res, Ogp>;
  @useResult
  $Res call({String title, String? imageUrl});
}

/// @nodoc
class _$OgpCopyWithImpl<$Res, $Val extends Ogp> implements $OgpCopyWith<$Res> {
  _$OgpCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Ogp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? imageUrl = freezed}) {
    return _then(
      _value.copyWith(
            title: null == title
                ? _value.title
                : title // ignore: cast_nullable_to_non_nullable
                      as String,
            imageUrl: freezed == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OgpImplCopyWith<$Res> implements $OgpCopyWith<$Res> {
  factory _$$OgpImplCopyWith(_$OgpImpl value, $Res Function(_$OgpImpl) then) =
      __$$OgpImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String title, String? imageUrl});
}

/// @nodoc
class __$$OgpImplCopyWithImpl<$Res> extends _$OgpCopyWithImpl<$Res, _$OgpImpl>
    implements _$$OgpImplCopyWith<$Res> {
  __$$OgpImplCopyWithImpl(_$OgpImpl _value, $Res Function(_$OgpImpl) _then)
    : super(_value, _then);

  /// Create a copy of Ogp
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? title = null, Object? imageUrl = freezed}) {
    return _then(
      _$OgpImpl(
        title: null == title
            ? _value.title
            : title // ignore: cast_nullable_to_non_nullable
                  as String,
        imageUrl: freezed == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc

class _$OgpImpl implements _Ogp {
  const _$OgpImpl({required this.title, this.imageUrl});

  // OGPのタイトル
  @override
  final String title;
  // OGPの画像URL
  @override
  final String? imageUrl;

  @override
  String toString() {
    return 'Ogp(title: $title, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OgpImpl &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @override
  int get hashCode => Object.hash(runtimeType, title, imageUrl);

  /// Create a copy of Ogp
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OgpImplCopyWith<_$OgpImpl> get copyWith =>
      __$$OgpImplCopyWithImpl<_$OgpImpl>(this, _$identity);
}

abstract class _Ogp implements Ogp {
  const factory _Ogp({required final String title, final String? imageUrl}) =
      _$OgpImpl;

  // OGPのタイトル
  @override
  String get title; // OGPの画像URL
  @override
  String? get imageUrl;

  /// Create a copy of Ogp
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OgpImplCopyWith<_$OgpImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
