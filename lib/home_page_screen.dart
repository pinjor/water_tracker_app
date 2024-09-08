import 'package:flutter/material.dart';
import 'package:water_tracker_app/WaterTrack.dart';

class HomePageScreen extends StatefulWidget {
  const HomePageScreen({super.key});

  @override
  State<HomePageScreen> createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  final TextEditingController _noOfGlassTEController = TextEditingController(
    text: '1',
  );

  List<WaterTrack> waterTrackList = [];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/water_home_2.png'), fit: BoxFit.cover),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appbar_widget(),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildWaterTrackCounter(),
            Expanded(
              child: _buildWaterTrackListview(),
            )
          ],
        ),
      ),
    );
  }

  Widget _buildWaterTrackListview() {
    return ListView.separated(
      itemCount: waterTrackList.length,
      itemBuilder: (context, index) {
        final WaterTrack waterTracks = waterTrackList[index];
        return ListTile(
          title: Text(
              '${waterTracks.dateTime.hour} : ${waterTracks.dateTime.minute}'),
          subtitle: Text(
              '${waterTracks.dateTime.day} - ${waterTracks.dateTime.month} - ${waterTracks.dateTime.year}'),
          leading: CircleAvatar(
            child: CircleAvatar(child: Text('${waterTracks.noOfGlasses}')),
          ),
          trailing: IconButton(
            onPressed: () => _onTapDeleteButton(index),
            icon: const Icon(Icons.delete),
          ),
        );
      },
      separatorBuilder: (context, index) {
        return const Divider();
      },
    );
  }

  Widget _buildWaterTrackCounter() {
    return Column(
      children: [
        Text(
          getNoOfGlasses().toString(),
          style: TextStyle(
              color: Color.fromARGB(255, 201, 255, 64), fontSize: 30.0),
        ),
        const Text(
          'Glasses of Water Consumed',
          style: TextStyle(color: Colors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 80,
              height: 10.0,
              child: TextField(
                controller: _noOfGlassTEController,
                keyboardType: TextInputType.number,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              width: 20.0,
            ),
            ElevatedButton(
              onPressed: () {
                _onTapAddButton();
                FocusScope.of(context).unfocus();
              },
              child: const Text('Add'),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    );
  }

  int getNoOfGlasses() {
    int counter = 0;
    for (WaterTrack t in waterTrackList) {
      counter += t.noOfGlasses;
    }
    return counter;
  }

  void _onTapAddButton() {
    if (_noOfGlassTEController.text.isEmpty) {
      _noOfGlassTEController.text = '1';
    }
    final int noOfGlasses = int.tryParse(_noOfGlassTEController.text) ?? 1;
    WaterTrack waterTrack =
        WaterTrack(noOfGlasses: noOfGlasses, dateTime: DateTime.now());

    waterTrackList.add(waterTrack);
    _noOfGlassTEController.clear();
    setState(() {});
  }

  void _onTapDeleteButton(int index) {
    waterTrackList.removeAt(index);
    setState(() {});
  }

  AppBar appbar_widget() {
    return AppBar(
      flexibleSpace: Image.asset(
        'assets/Appbar_background.png',
        fit: BoxFit.fill,
      ),
      title: const Text(
        'Water Consumption App',
        style: TextStyle(
          color: Colors.white,
        ),
      ),
      centerTitle: true,
    );
  }
}
