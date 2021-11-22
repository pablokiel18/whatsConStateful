import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main() => runApp(what());

class what extends StatefulWidget {
  String nombre = "Jason";

  @override
  createState() => Estado();
}

class Estado extends State<what> with TickerProviderStateMixin {
  String nombre = "Jason";
  bool _isTyped = false;
  final TextEditingController _textController = TextEditingController();
  final List<MensajeChat> _mensajes =<MensajeChat>[];

  void _handleSubmit(String text){
    _textController.clear();
    setState((){
      _isTyped = false;
    });
    MensajeChat mensaje = MensajeChat(
      text: text,
      animationController: AnimationController(
        duration: Duration(milliseconds: 600),
        vsync: this),
    );
      setState((){
        _mensajes.insert(0, mensaje);
      });
mensaje.animationController.forward();
    print(text);
  }

  Widget _buildTextComposer(){
    return Container(
     decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.lime[50],

      ),

      child: Row(
        children: [
          Flexible(
          child:
              TextField(
                controller: _textController,
                onChanged: (String text){
                  setState((){
                    _isTyped = text.length > 0;
                  });
                },

            decoration:

            InputDecoration.collapsed(
                border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0)
                ),
                hintText: "Enviar mensaje"),

          )),

          Container(
          child: IconButton(
            icon: Icon(Icons.send, color: Colors.lightGreen),
            onPressed: _isTyped ?
                () => _handleSubmit(_textController.text) :
            null,
          )),
        ],
      ),
    );
  }

  @override
  void initState() {

  }

  @override
  Widget build(BuildContext context) => MaterialApp(


      home: Container(
      decoration: const BoxDecoration(
            image: DecorationImage(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRxe5-m3wjOgO9jGiO4ZbVsm3AQCKbblQaZbA&usqp=CAU"),
          fit: BoxFit.cover,
          ),
          ),

        child: Scaffold(
        backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.green,
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {}, icon: Icon(Icons.arrow_back_sharp)),
              title: ListTile(
                leading: const CircleAvatar(
                  backgroundImage: NetworkImage(
                      "https://i.blogs.es/4738fa/halloweenkills1/1366_2000.jpg"),
                ),
                title: Text("$nombre"),

                subtitle: Text("últ. vez hoy 21:29"),
              ),
              actions: <Widget>[
                IconButton(onPressed: () {}, icon: Icon(Icons.phone)),
                IconButton(onPressed: () {}, icon: Icon(Icons.attach_file)),
                IconButton(onPressed: () {}, icon: Icon(Icons.menu_outlined)),
              ],
            ),

          body:
          Container(
            child: Column(
             children: [
              Flexible(
                  child: ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    reverse: true,
                    itemBuilder: (_, int index) => _mensajes[index],
                    itemCount: _mensajes.length,

                  ),
              ),
              Divider(height: 1.0),
              Container(
                child: _buildTextComposer(),
              ),
            ],


          ),

        ),


  )));

}

class MensajeChat extends StatelessWidget{

  MensajeChat({required this.text, required this.animationController});

  final String text;
  final AnimationController animationController;

  @override
  Widget build(BuildContext context){
    return SizeTransition(
      sizeFactor: CurvedAnimation(
          parent: animationController,
          curve: Curves.easeOut),
      child:  Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.green,

        ),

        width: 250,




        //color: Colors.green,
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(right: 4.0),
              alignment: Alignment.centerLeft,
              child: const CircleAvatar(
                child: Text("PK"),

              ),
            ),
           Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 5.0),
                    child: Text(text),
                  ),

                ],
              ),

            )
          ],
        ),

      ),

    );
  }

}




