import 'package:flutter/material.dart';
import 'package:project/models/data.dart';
import 'package:project/models/moodModel.dart';
import 'package:project/widgets/moodSummary.dart';
import 'package:project/widgets/moodTile.dart';
import 'package:provider/provider.dart';

class SelfCare extends StatefulWidget {
  const SelfCare({super.key});

  @override
  State<SelfCare> createState() => _SelfCareState();
}

class _SelfCareState extends State<SelfCare> {
  final newMoodAmountController = TextEditingController();
  final newMoodnameController = TextEditingController();

  @override
  void initState(){
    super.initState();
    Provider.of<MoodData>(context,listen: false).prepareData();
  }

  void addNewMood() {
    showDialog(
        context: context,
        builder: (context) => AlertDialog(
              title: Text('Tap to add Mood!'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Image.asset("images/1 emoji.png",height: 40,width: 40,),
                      Image.asset("images/2 emoji.png",height: 40,width: 40,),
                      Image.asset("images/3 emoji.png",height: 40,width: 40,),
                      Image.asset("images/4 emoji.png",height: 40,width: 40,),
                      Image.asset("images/5 emoji.png",height: 40,width: 40,),
                    ],
                  ),
                  TextField(
                    controller: newMoodnameController,
                  ),
                  TextField(
                    controller: newMoodAmountController,
                    keyboardType: TextInputType.number,
                  ),
                ],
              ),
              actions: [
                MaterialButton(
                  onPressed: save,
                  child: Text('Save'),
                ),
                MaterialButton(
                  onPressed: cancel,
                  child: Text('Cancel'),
                )
              ],
            ));
  }

  void save() {
    MoodItem newMood = MoodItem(
        mood: newMoodnameController.text,
        amt: newMoodAmountController.text,
        dateTime: DateTime.now());
    Provider.of<MoodData>(context, listen: false).addNewMood(newMood);
    Navigator.pop(context);
    clear();
  }

  void cancel() {
    Navigator.pop(context);
    clear();
  }

  void clear() {
    newMoodAmountController.clear();
    newMoodnameController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<MoodData>(
      builder: (context, value, child) => Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: addNewMood,
            child: Icon(Icons.add),
          ),
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.black, size: 35),
          ),
          body: ListView(children: [
            SizedBox(height: 50,),
            MoodSummary(startOfWeek: value.startOfWeekDate()),
            SizedBox(height: 30,),
            Center(child: const Text('Weekly Mood Graph',style: TextStyle(fontSize: 20,color: Colors.black87),)),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) => MoodTile(
                  name: value.getAllMoodList()[index].mood,
                  amount: value.getAllMoodList()[index].amt,
                  dateTime: value.getAllMoodList()[index].dateTime),
              itemCount: value.getAllMoodList().length,
            ),
          ])),
    );
  }
}
