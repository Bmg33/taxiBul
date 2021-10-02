// ignore_for_file: file_names

class DirectionDetails {
  int distanceValue;
  int durationValue;
  String distanceText;
  String durationText;

  String encodedPoints;

  DirectionDetails(
      {this.distanceText,
      this.distanceValue,
      this.durationText,
      this.durationValue,
      this.encodedPoints});
}
