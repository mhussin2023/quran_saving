import 'package:flutter/material.dart';

import '../../storage_modules.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key, required this.refreshMainPage});
  final Function refreshMainPage;



  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DataStorage.getFilesNames().then((onValue) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    var smallSpace = SizedBox(height: 30,);
   // DataStorage.getFilesNames();
    print('length is ${DataStorage.dataFilesNames.length}');
var buttonTextStyle=TextStyle(
  fontSize: 20,
  color: Colors.black
);


    return Scaffold(
      appBar: AppBar(

      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
       // crossAxisAlignment: CrossAxisAlignment.stretch,
        // mainAxisSize: MainAxisSize.max,
      
        children: [
          SizedBox(height: 100,),
          Directionality(
      
            textDirection: TextDirection.rtl,
            child: ChoiceChip(
      
              label: Text(
                  style: buttonTextStyle,
                  'العرض فى عامود'),
              onSelected: (value) {
                setState(() {
                  DataStorage.listType = value;
                });
      
                widget.refreshMainPage();
                goBack();
              },
              selected: DataStorage.listType,
            ),
          ),
          smallSpace,
          ElevatedButton(onPressed: () {
            DataStorage.clearStatusList();
            widget.refreshMainPage();
            goBack();
          },
              child: Text(
                  style: buttonTextStyle,
                  "بدء ختمة جديدة"))
          ,
          smallSpace,
          ElevatedButton(onPressed: () async {
            // String? feedback=dialogClass.showAlertDialog(context);
            //print(feedback);
            String fileName=await getFileName();
            DataStorage.saveToDevice(fileName);
          }, child: Text(
              style: buttonTextStyle,
              textAlign: TextAlign.center,
              "حفظ بيانات الختمة\n على الهاتف")),
      
          smallSpace,
          Container(
            padding: EdgeInsets.all(5),
            color: Colors.cyan,
            height: 200,
            width: double.infinity,
            child: SingleChildScrollView(
              child: Column(
                children:
                  {for  (int i=0;i<DataStorage.dataFilesNames.length;i++)
                    GestureDetector(
                      onDoubleTap: (){
                        print('double tapped$i');
                      },
                      child: Container(
                        width: double.maxFinite,
                        color:(i%2==0)? Colors.white:Colors.lightGreenAccent,
                        child: Text(
                          style: TextStyle(fontSize: 20),
                            DataStorage.dataFilesNames[i]),
                      ),
                    )
                  }
                      .toList()



            )

                  ),
            ),

      
      
        ],
      
      ),
    );
  }

  void goBack() {
    Navigator.pop(context);
  }

  Future<String> getFileName() async {
    String _fileName='';
    TextEditingController _controller=TextEditingController();
    _fileName=await showDialog(context: context,

        builder: (BuildContext context) {
      return AlertDialog(
        title: Title(color: Colors.cyan, child: Text('أدخل اسم الختمة')),
        content: TextField(
          controller: _controller,
        ),
        actions: [
          ElevatedButton(onPressed: (){
            _fileName=_controller.text;
            print('filename=$_fileName');
            Navigator.pop(context,_fileName);
          }, child: Text('ok'))
          ]
      );
        } );
    return _fileName;
  }

}

  // void refreshMainPage() {
  //   setState(() {
  //
  //   });



//}
