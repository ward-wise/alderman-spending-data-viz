import 'package:alderman_spending/src/data/loaders.dart';
import 'package:alderman_spending/src/data/models/ward_info.dart';
import 'package:alderman_spending/src/services/ward_lookup_request.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:syncfusion_flutter_maps/maps.dart';

const String mapShapePath = 'assets/Wards-Boundaries.geojson';
const Map<int, List<double>> wardCentroidCoordinates = {
  1: [41.9115084911536, -87.6834578873681],
  2: [41.90647465180663, -87.63630899994621],
  3: [41.82796192047113, -87.62400644006627],
  4: [41.833281814322696, -87.609156330931],
  5: [41.781069215386886, -87.58696716133747],
  6: [41.754724400737125, -87.62232015857712],
  7: [41.73666037410328, -87.56347090045676],
  8: [41.7355169930584, -87.59148145964286],
  9: [41.688905158145865, -87.61811232786886],
  10: [41.68416262173096, -87.5590562067184],
  11: [41.83329922414175, -87.64794345284803],
  12: [41.824550388429486, -87.68793449100205],
  13: [41.78305829271895, -87.76084139285601],
  14: [41.80253414388308, -87.71468374121102],
  15: [41.796806837968184, -87.67625302022464],
  16: [41.78298818058196, -87.66530221407197],
  17: [41.75720916798535, -87.66465641771849],
  18: [41.747998813231064, -87.7051870211254],
  19: [41.70111894948101, -87.68875482407991],
  20: [41.791608997930766, -87.62655386046708],
  21: [41.70481692974228, -87.64683956828094],
  22: [41.83263031057105, -87.7280856069176],
  23: [41.7862714866061, -87.74160525397295],
  24: [41.86142964845666, -87.71919425289786],
  25: [41.850695128044016, -87.67319382683368],
  26: [41.91135742315808, -87.71643137433237],
  27: [41.88968104457844, -87.67474952917334],
  28: [41.874273726839, -87.69982199968916],
  29: [41.90049375845594, -87.77880823340818],
  30: [41.94130956058458, -87.7552958049784],
  31: [41.932577027772176, -87.74617991748369],
  32: [41.92735668609853, -87.67410178134853],
  33: [41.95937406150413, -87.70982136397032],
  34: [41.87766319946123, -87.64511319556887],
  35: [41.93317575002999, -87.71148724121107],
  36: [41.91479822983443, -87.74718883759355],
  37: [41.90009125508913, -87.74799968326785],
  38: [41.950865544910044, -87.81091403455116],
  39: [41.981639445522404, -87.73937324919794],
  40: [41.98485568115007, -87.68551447471646],
  41: [41.98186507027488, -87.87510330231493],
  42: [41.887991032196666, -87.62501698518892],
  43: [41.92155550838724, -87.64191986649715],
  44: [41.9416220307082, -87.64975642790486],
  45: [41.97864713346017, -87.76652880922695],
  46: [41.95979962380499, -87.65149206315017],
  47: [41.95795316051116, -87.67958081999767],
  48: [41.98444054364749, -87.65921624550366],
  49: [42.010602647972, -87.67079475721036],
  50: [42.00254798792905, -87.70055631463124],
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
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      wardsInformation = await loadWardsInformation();
    });
    // Doesn't work for no reason???
    // loadWardsInformation().then((value) =>
    //   setState(() {
    //     wardsInformation = value;
    //   })
    // );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
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
                addressLookupForm(),
                if (_selectedWard != null) Text("Ward $_selectedWard"),
              ],
            )),
            Expanded(child: HighlightedWardMap(selectedWard: _selectedWard)),
          ],
        ),
        WardContactCard(wardNumber: _selectedWard),
      ],
    ));
  }

  Widget landscapeLayout() {
    return const Placeholder();
  }

  Widget addressLookupForm() {
    return TextFormField(
      // TODO Validation function
      // TODO Add timer to prevent spamming
      decoration: const InputDecoration(labelText: "Enter Address"),
      // REST call using getWard() from WardLookupRequest
      onFieldSubmitted: (value) async {
        try {
          final ward = await getWard(value);
          setState(() => _selectedWard = ward);
        } catch (e) {
          setState(() => _selectedWard = null);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(e.toString()),
            ),
          );
        }
      },
    );
  }
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
  final MapZoomPanBehavior _zoomPanBehavior =
      MapZoomPanBehavior(showToolbar: false);
  final _mapSelectionSettings = const MapSelectionSettings(
    color: Colors.teal,
    strokeColor: Colors.black,
    strokeWidth: 1,
  );

// TODO fix stupid dumb little zoom code that only works on changing ward but not initial selection
  @override
  void didUpdateWidget(covariant HighlightedWardMap oldWidget) {
    // _zoomPanBehavior.focalLatLng = MapLatLng(
    //     wardCentroidCoordinates[widget.selectedWard]![0],
    //     wardCentroidCoordinates[widget.selectedWard]![1]);
    // _zoomPanBehavior.zoomLevel = 2;
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: SfMaps(
        layers: [
          MapShapeLayer(
            zoomPanBehavior: _zoomPanBehavior,
            source: mapDataSource,
            selectedIndex: widget.selectedWard ?? -1,
            selectionSettings: _mapSelectionSettings,
          ),
        ],
      ),
    );
  }
}

class WardContactCard extends StatefulWidget {
  final int? wardNumber;
  const WardContactCard({
    super.key,
    this.wardNumber,
  });

  @override
  State<WardContactCard> createState() => _WardContactCardState();
}

class _WardContactCardState extends State<WardContactCard> {
  Image? avatarImage;
  WardInformation? wardInfo;

  @override
  void didUpdateWidget(covariant WardContactCard oldWidget) {
    if (widget.wardNumber != null) {
      wardInfo = wardsInformation[widget.wardNumber! - 1];
      avatarImage = Image.asset(
        "images/alderpeople/ward_${widget.wardNumber}.png",
        errorBuilder: (context, error, stackTrace) {
          return const Icon(Icons.person);
        },
      );
    } else {
      avatarImage = null;
      wardInfo = null;
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  Widget build(BuildContext context) {
    return GFListTile(
      avatar: avatarImage ?? const Icon(Icons.person),
      title: Text(wardInfo?.alderpersonName ?? "Alderperson"),
      subTitle: Text(wardInfo?.wardEmail ?? "Email"),
    );
  }
}
