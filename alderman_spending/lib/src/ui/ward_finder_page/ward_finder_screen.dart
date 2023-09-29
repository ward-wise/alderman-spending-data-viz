import 'dart:io';
import 'dart:js_interop';

import 'package:alderman_spending/src/data/loaders.dart';
import 'package:alderman_spending/src/data/models/ward_info.dart';
import 'package:alderman_spending/src/services/ward_lookup_request.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

const String mapShapePath = 'assets/Wards-Boundaries.geojson';

const Map<int, List<double>> wardCentroidCoordinates = {
  1: [-87.6834578873681, 41.9115084911536],
  2: [-87.63630899994621, 41.90647465180663],
  3: [-87.62400644006627, 41.82796192047113],
  4: [-87.609156330931, 41.833281814322696],
  5: [-87.58696716133747, 41.781069215386886],
  6: [-87.62232015857712, 41.754724400737125],
  7: [-87.56347090045676, 41.73666037410328],
  8: [-87.59148145964286, 41.7355169930584],
  9: [-87.61811232786886, 41.688905158145865],
  10: [-87.5590562067184, 41.68416262173096],
  11: [-87.64794345284803, 41.83329922414175],
  12: [-87.68793449100205, 41.824550388429486],
  13: [-87.76084139285601, 41.78305829271895],
  14: [-87.71468374121102, 41.80253414388308],
  15: [-87.67625302022464, 41.796806837968184],
  16: [-87.66530221407197, 41.78298818058196],
  17: [-87.66465641771849, 41.75720916798535],
  18: [-87.7051870211254, 41.747998813231064],
  19: [-87.68875482407991, 41.70111894948101],
  20: [-87.62655386046708, 41.791608997930766],
  21: [-87.64683956828094, 41.70481692974228],
  22: [-87.7280856069176, 41.83263031057105],
  23: [-87.74160525397295, 41.7862714866061],
  24: [-87.71919425289786, 41.86142964845666],
  25: [-87.67319382683368, 41.850695128044016],
  26: [-87.71643137433237, 41.91135742315808],
  27: [-87.67474952917334, 41.88968104457844],
  28: [-87.69982199968916, 41.874273726839],
  29: [-87.77880823340818, 41.90049375845594],
  30: [-87.7552958049784, 41.94130956058458],
  31: [-87.74617991748369, 41.932577027772176],
  32: [-87.67410178134853, 41.92735668609853],
  33: [-87.70982136397032, 41.95937406150413],
  34: [-87.64511319556887, 41.87766319946123],
  35: [-87.71148724121107, 41.93317575002999],
  36: [-87.74718883759355, 41.91479822983443],
  37: [-87.74799968326785, 41.90009125508913],
  38: [-87.81091403455116, 41.950865544910044],
  39: [-87.73937324919794, 41.981639445522404],
  40: [-87.68551447471646, 41.98485568115007],
  41: [-87.87510330231493, 41.98186507027488],
  42: [-87.62501698518892, 41.887991032196666],
  43: [-87.64191986649715, 41.92155550838724],
  44: [-87.64975642790486, 41.9416220307082],
  45: [-87.76652880922695, 41.97864713346017],
  46: [-87.65149206315017, 41.95979962380499],
  47: [-87.67958081999767, 41.95795316051116],
  48: [-87.65921624550366, 41.98444054364749],
  49: [-87.67079475721036, 42.010602647972],
  50: [-87.70055631463124, 42.00254798792905]
};

final mapDataSource = MapShapeSource.asset(
  mapShapePath,
  shapeDataField: 'ward',
  dataCount: 51,
  primaryValueMapper: (int index) => index.toString(),
);

List<WardInformation> wardsInformation = [];

class WardFinderScreen extends StatefulWidget {
  const WardFinderScreen({Key? key}) : super(key: key);

  @override
  State<WardFinderScreen> createState() => _WardFinderScreenState();
}

class _WardFinderScreenState extends State<WardFinderScreen> {
  int? _selectedWard;

  @override
  void initState() {
    loadWardsInformation().then((value) => 
      setState(() {
        wardsInformation = value;
      })
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // LayoutBuilder based on aspect ratio
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        if (MediaQuery.of(context).size.aspectRatio < 1.3) {
          return portraitLayout();
        }
        // TODO Make landscape layout
        return landscapeLayout();
      },
    );
  }

  Widget portraitLayout() {
    return Scaffold(
        body: Column(
      children: [
        Row(
          children: [
            Expanded(
                child: Column(
              children: [
                TextFormField(
                  decoration: const InputDecoration(labelText: "Enter Address"),
                  // REST call using getWard() from WardLookupRequest
                  onFieldSubmitted: (value) async {
                    final ward = await getWard(value);
                    setState(() {
                      _selectedWard = ward;
                    });
                  },
                ),
                if (_selectedWard != null) Text("Ward $_selectedWard"),
              ],
            )),
            HighlightedWardMap(selectedWard: _selectedWard),
          ],
        ),
        WardContactCard(wardNumber: _selectedWard),
      ],
    ));
  }
}

Widget landscapeLayout() {
  return const Placeholder();
}

class HighlightedWardMap extends StatefulWidget {
  final int? selectedWard;

  const HighlightedWardMap({
    super.key,
    this.selectedWard,
  });

  @override
  State<HighlightedWardMap> createState() => _HighlightedWardMapState();
}

class _HighlightedWardMapState extends State<HighlightedWardMap> {
  MapZoomPanBehavior? _zoomPanBehavior;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didUpdateWidget(covariant HighlightedWardMap oldWidget) {
    if (widget.selectedWard != oldWidget.selectedWard) {
      setState(() {
        _zoomPanBehavior = MapZoomPanBehavior(
          focalLatLng: MapLatLng(
            wardCentroidCoordinates[widget.selectedWard]![0],
            wardCentroidCoordinates[widget.selectedWard]![1],
          ),
          zoomLevel: 3,
        );
      });
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SfMaps(
        layers: [
          MapShapeLayer(
            source: mapDataSource,
            selectedIndex: widget.selectedWard ?? -1,
            selectionSettings: const MapSelectionSettings(
              color: Colors.teal,
              strokeColor: Colors.black,
              strokeWidth: 1,
            ),
            zoomPanBehavior: _zoomPanBehavior,
          ),
        ],
      ),
    );
  }
}

class WardContactCard extends StatefulWidget {
  final int? wardNumber;
  const WardContactCard({super.key, this.wardNumber});
  
  @override
  State<WardContactCard> createState() => _WardContactCardState();
}

class _WardContactCardState extends State<WardContactCard> {
  Image? avatarImage;
  WardInformation? wardInfo;
  @override
  void initState() {
    wardInfo = wardsInformation[widget.wardNumber! - 1];
    avatarImage = Image.asset("images/alderpeople/ward_${widget.wardNumber}.png");
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    if (wardInfo == null || avatarImage == null) {
      return const CircularProgressIndicator();
    }
    return GFListTile(
      avatar: avatarImage,
      title: Text(wardInfo!.alderpersonName),
    );
  }
}