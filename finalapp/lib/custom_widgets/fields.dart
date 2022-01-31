import 'package:flutter/material.dart';

class InField extends StatefulWidget {
  final text;
  final hide;
  final control;
  final type;
  final typo;
  InField(this.text, this.hide, this.control, this.type, this.typo);
  @override
  _InFieldState createState() => _InFieldState(text,hide,control,type,typo);
}
class _InFieldState extends State<InField> {
  late final text;
  late final hide;
  late final control;
  late final type;
  late final typo;
  _InFieldState(this.text,this.hide,this.control,this.type, this.typo);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: typo == 0? 350 : 392,
      height: typo == 0? 60 : 70,
      padding: const EdgeInsets.all(5),
      child: TextFormField(
        keyboardType: (type == 1)? TextInputType.emailAddress : TextInputType.text,
        controller: control,
        obscureText: hide,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          labelText: text,
        ),
      ),
    );
  }
}

class Dash extends StatelessWidget {
  const Dash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
      child: Container(
        height: 1,
        decoration: BoxDecoration(
          color: Colors.grey[300],
        ),
      ),
    );
  }
}

class ButtonText extends StatelessWidget {
  ButtonText(this.text);
  final text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(15,0,10,0),
      child: TextButton(onPressed: (){}, child: Text(text, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.normal, fontSize: 17))),
    );
  }
}

class NormalText extends StatelessWidget {
  NormalText(this.text, this.top, this.bottom);
  final text; final top; final bottom;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(23,top,10,bottom),
      child: Text(text, style: const TextStyle(color: Colors.black, fontSize: 17)),
    );
  }
}


class SearchField extends StatelessWidget {
  const SearchField({Key? key, required this.fieldname, required this.iconId})
      : super(key: key);

  final String fieldname;
  final int iconId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(5,10,5,10),
      child: SizedBox(
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
              primary: Colors.white,
              side: const BorderSide(width: 0.5, color: Colors.grey)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  Icon(
                      IconData(iconId, fontFamily: 'MaterialIcons'),
                    color: Colors.black,
                  ),
                  const SizedBox(
                    width: 2.5,
                  ),
                  Text(
                    fieldname,
                    style: const TextStyle(fontStyle: FontStyle.normal, color: Colors.black, fontWeight: FontWeight.normal),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class editPro extends StatelessWidget {
  editPro(this.button, this.text);
  final button;final text;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: OutlinedButton(
        onPressed: (){
          if(button == 2)
            {
              Navigator.of(context).pushNamed('/reset');
            }
        },
        child: Text(text, style: const TextStyle(color: Colors.blue),),
        style: OutlinedButton.styleFrom(
            primary: Colors.blueAccent,
            minimumSize: const Size(380,60),
            padding: const EdgeInsets.all(10),
            side: const BorderSide(color: Colors.black26,)),
      ),
    );
  }
}