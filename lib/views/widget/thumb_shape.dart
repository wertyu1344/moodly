/*
FlutterSlider(
values: [
_position?.inSeconds.toDouble() ?? 0,
],
max: _duration?.inSeconds.toDouble() ?? 1,
min: 0,
selectByTap: false,
rtl: false,
onDragging: (handlerIndex, lowerValue, upperValue) {
if (duration != null) {
final position = handlerIndex * duration.inMilliseconds;
_audioPlayer.seek(Duration(milliseconds: position.round()));
}
},
trackBar: FlutterSliderTrackBar(
activeTrackBarHeight: 6,
activeDisabledTrackBarColor: widget.dayModel.emoji.color),
rangeSlider: false,
handler: FlutterSliderHandler(
child: Material(
type: MaterialType.canvas,
color: Colors.transparent,
elevation: 0,
child: Image.asset(
widget.dayModel.emoji.url,
width: 40,
height: 40,
)),
// onChanged: (v) {
//   if (duration != null) {
//     final position = v * duration.inMilliseconds;
//     _audioPlayer.seek(Duration(milliseconds: position.round()));
//   }
// },
),
),
*/
