//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//
// @dart=2.18

// ignore_for_file: unused_element, unused_import
// ignore_for_file: always_put_required_named_parameters_first
// ignore_for_file: constant_identifier_names
// ignore_for_file: lines_longer_than_80_chars

part of openapi.api;

class AnalysisReview {
  /// Returns a new [AnalysisReview] instance.
  AnalysisReview({
    this.probabilityFructose,
    this.probabilityGluten,
    this.probabilityLactose,
    this.probabilitySorbite,
    this.reviewResult,
    this.reviewComment,
  });

  /// The probability of fructose intolerance
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? probabilityFructose;

  /// The probability of gluten intolerance
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? probabilityGluten;

  /// The probability of lactose intolerance
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? probabilityLactose;

  /// The probability of sorbitol intolerance
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  num? probabilitySorbite;

  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  IntoleranceTreatment? reviewResult;

  /// A comment from the dietitian about the analysis review
  ///
  /// Please note: This property should have been non-nullable! Since the specification file
  /// does not include a default value (using the "default:" property), however, the generated
  /// source code must fall back to having a nullable type.
  /// Consider adding a "default:" property in the specification file to hide this note.
  ///
  String? reviewComment;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AnalysisReview &&
          other.probabilityFructose == probabilityFructose &&
          other.probabilityGluten == probabilityGluten &&
          other.probabilityLactose == probabilityLactose &&
          other.probabilitySorbite == probabilitySorbite &&
          other.reviewResult == reviewResult &&
          other.reviewComment == reviewComment;

  @override
  int get hashCode =>
      // ignore: unnecessary_parenthesis
      (probabilityFructose == null ? 0 : probabilityFructose!.hashCode) +
      (probabilityGluten == null ? 0 : probabilityGluten!.hashCode) +
      (probabilityLactose == null ? 0 : probabilityLactose!.hashCode) +
      (probabilitySorbite == null ? 0 : probabilitySorbite!.hashCode) +
      (reviewResult == null ? 0 : reviewResult!.hashCode) +
      (reviewComment == null ? 0 : reviewComment!.hashCode);

  @override
  String toString() =>
      'AnalysisReview[probabilityFructose=$probabilityFructose, probabilityGluten=$probabilityGluten, probabilityLactose=$probabilityLactose, probabilitySorbite=$probabilitySorbite, reviewResult=$reviewResult, reviewComment=$reviewComment]';

  Map<String, dynamic> toJson() {
    final json = <String, dynamic>{};
    if (this.probabilityFructose != null) {
      json[r'probabilityFructose'] = this.probabilityFructose;
    } else {
      json[r'probabilityFructose'] = null;
    }
    if (this.probabilityGluten != null) {
      json[r'probabilityGluten'] = this.probabilityGluten;
    } else {
      json[r'probabilityGluten'] = null;
    }
    if (this.probabilityLactose != null) {
      json[r'probabilityLactose'] = this.probabilityLactose;
    } else {
      json[r'probabilityLactose'] = null;
    }
    if (this.probabilitySorbite != null) {
      json[r'probabilitySorbite'] = this.probabilitySorbite;
    } else {
      json[r'probabilitySorbite'] = null;
    }
    if (this.reviewResult != null) {
      json[r'reviewResult'] = this.reviewResult;
    } else {
      json[r'reviewResult'] = null;
    }
    if (this.reviewComment != null) {
      json[r'reviewComment'] = this.reviewComment;
    } else {
      json[r'reviewComment'] = null;
    }
    return json;
  }

  /// Returns a new [AnalysisReview] instance and imports its values from
  /// [value] if it's a [Map], null otherwise.
  // ignore: prefer_constructors_over_static_methods
  static AnalysisReview? fromJson(dynamic value) {
    if (value is Map) {
      final json = value.cast<String, dynamic>();

      // Ensure that the map contains the required keys.
      // Note 1: the values aren't checked for validity beyond being non-null.
      // Note 2: this code is stripped in release mode!
      assert(() {
        requiredKeys.forEach((key) {
          assert(json.containsKey(key),
              'Required key "AnalysisReview[$key]" is missing from JSON.');
          assert(json[key] != null,
              'Required key "AnalysisReview[$key]" has a null value in JSON.');
        });
        return true;
      }());

      return AnalysisReview(
        probabilityFructose: num.parse('${json[r'probabilityFructose']}'),
        probabilityGluten: num.parse('${json[r'probabilityGluten']}'),
        probabilityLactose: num.parse('${json[r'probabilityLactose']}'),
        probabilitySorbite: num.parse('${json[r'probabilitySorbite']}'),
        reviewResult: IntoleranceTreatment.fromJson(json[r'reviewResult']),
        reviewComment: mapValueOfType<String>(json, r'reviewComment'),
      );
    }
    return null;
  }

  static List<AnalysisReview> listFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final result = <AnalysisReview>[];
    if (json is List && json.isNotEmpty) {
      for (final row in json) {
        final value = AnalysisReview.fromJson(row);
        if (value != null) {
          result.add(value);
        }
      }
    }
    return result.toList(growable: growable);
  }

  static Map<String, AnalysisReview> mapFromJson(dynamic json) {
    final map = <String, AnalysisReview>{};
    if (json is Map && json.isNotEmpty) {
      json = json.cast<String, dynamic>(); // ignore: parameter_assignments
      for (final entry in json.entries) {
        final value = AnalysisReview.fromJson(entry.value);
        if (value != null) {
          map[entry.key] = value;
        }
      }
    }
    return map;
  }

  // maps a json object with a list of AnalysisReview-objects as value to a dart map
  static Map<String, List<AnalysisReview>> mapListFromJson(
    dynamic json, {
    bool growable = false,
  }) {
    final map = <String, List<AnalysisReview>>{};
    if (json is Map && json.isNotEmpty) {
      // ignore: parameter_assignments
      json = json.cast<String, dynamic>();
      for (final entry in json.entries) {
        map[entry.key] = AnalysisReview.listFromJson(
          entry.value,
          growable: growable,
        );
      }
    }
    return map;
  }

  /// The list of required keys that must be present in a JSON.
  static const requiredKeys = <String>{};
}
