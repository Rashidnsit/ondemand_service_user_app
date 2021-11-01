import 'package:flutter/material.dart';

class PostRequest extends StatelessWidget {
  const PostRequest({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Post a Request"),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 10,
        color: Colors.transparent,
        child: Customutton(
          buttonName: "Submit Your Request",
          buttonTextColor: Colors.white,
          color: Colors.greenAccent.shade400,
          ontap: () {},
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(left: 10, top: 12),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5),
              Text(
                "Add a description",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Divider(
                height: 1,
              ),
              _buildTextField(),
              Divider(
                height: 1,
              ),
              SizedBox(height: 8),
              Text(
                "Choose a category",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Divider(
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.folder),
                title: Text(
                  'Category',
                  textScaleFactor: 1.3,
                ),
                trailing: Icon(Icons.keyboard_arrow_down_outlined),
                onTap: () {},
              ),
              Divider(
                height: 1,
              ),
              SizedBox(height: 8),
              Text(
                "When Would you like your service delivered",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Divider(
                height: 1,
              ),
              ListTile(
                leading: Icon(Icons.access_time),
                title: Text(
                  'Delivery Time',
                  textScaleFactor: 1.3,
                ),
                trailing: Icon(Icons.keyboard_arrow_down_outlined),
                onTap: () {},
              ),
              Divider(
                height: 1,
              ),
              SizedBox(height: 8),
              Text(
                "What is your budget?",
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Divider(),
              _buildTextField2(),
              Divider(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField() {
    final maxLines = 6;

    return Container(
      margin: EdgeInsets.all(5),
      height: maxLines * 24.0,
      child: TextField(
        maxLength: 300,
        keyboardType: TextInputType.multiline,
        maxLines: maxLines,
        decoration: new InputDecoration.collapsed(
          hintText: "Max 300 Characters.",
        ),
      ),
    );
  }

  Widget _buildTextField2() {
    final maxLines = 1;

    return Container(
      margin: EdgeInsets.all(5),
      height: maxLines * 30.0,
      child: TextField(
        keyboardType: TextInputType.number,
        maxLines: maxLines,
        decoration: new InputDecoration.collapsed(
          hintText: "Budget Min. 100 INR",
        ),
      ),
    );
  }
}

class Customutton extends StatelessWidget {
  final String buttonName;
  final Color color;
  final Color buttonTextColor;

  final Function() ontap;

  const Customutton(
      {Key key, this.buttonName, this.color, this.ontap, this.buttonTextColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Container(
        width: MediaQuery.of(context).size.width / 2.4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: color,
        ),
        child: TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
            primary: buttonTextColor,
            textStyle: const TextStyle(fontSize: 16),
          ),
          onPressed: ontap,
          child: Text(buttonName),
        ),
      ),
    );
  }
}
