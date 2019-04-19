import'package:flutter/material.dart';
import'package:flutter/services.dart';
import "dart:typed_data";
const String A = "0123456789abcdef";
void main()=>runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    theme:ThemeData(accentColor:Colors.white),
    home:Home())
  );
class Home extends StatefulWidget{
  @override
  _Home createState()=>_Home();
}
class _Home extends State<Home>{
  var h=0xff000;
  var r=0,g=0,b=0;
  var wht=Colors.white;
  var blk=Colors.black;
  var rd=Colors.red;
  var txt=TextEditingController(),rc=TextEditingController(text: '0'),bc=TextEditingController(text: '0'),gc=TextEditingController(text: '0');
  bool v=true;
  @override
  Widget build(BuildContext cxt){
    SystemChrome.setEnabledSystemUIOverlays([]);
    OutlineInputBorder o=new OutlineInputBorder(borderRadius:BorderRadius.all(Radius.circular(50)));
    return Scaffold(
      backgroundColor:Color(h),
      resizeToAvoidBottomPadding:false,
      body:Flex(children:<Widget>[
        Expanded(
          flex:1,
          child:Container(
          decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(20)),color:wht),
          child:Row(
            mainAxisAlignment:MainAxisAlignment.center,
            crossAxisAlignment:CrossAxisAlignment.stretch,
            children:<Widget>[
              E(cxt,rd,'R',rc),
              E(cxt,Colors.green,'G',gc),
              E(cxt,Colors.blue,'B',bc)
            ],
          ),
        )),
        Expanded(
          flex:10,
          child:Center(
          child:Container(
              width:140,
              height:65,
              decoration:BoxDecoration(
                  color:wht,
                  boxShadow:[BoxShadow(color:Colors.grey,blurRadius:3,spreadRadius:2)],
                  borderRadius:BorderRadius.all(Radius.circular(50))),
              child:TextField(
                  controller:txt,
                  cursorColor:!v?rd:wht,
                  maxLength:6,
              decoration:InputDecoration(
                prefixText:'#',
                hintText:'HEX',
                hintStyle:TextStyle(color: blk),
                prefixStyle:TextStyle(color:!v?rd:blk,fontSize:20,fontWeight:FontWeight.bold),
                counterText:'',
                focusedBorder:o,
                enabledBorder:o,
              ),
              style:TextStyle(color:!v?rd:blk,fontWeight:FontWeight.bold,fontSize:20,letterSpacing:3),
              onChanged:(c){
                setState((){
                  try{
                    v=true;
                    h=int.parse('0xff'+c);
                  }on Exception{
                    v=false;
                  }
                  r=de(c)[0];
                  g=de(c)[1];
                  b=de(c)[2];
                  rc.text=r.toString();
                  gc.text=g.toString();
                  bc.text=b.toString();
                });
              }))))
    ], direction:Axis.vertical));
  }
  Widget E(BuildContext cxt,cst,hnt,ctr){
    return Expanded(
      child:Container(
        padding:EdgeInsets.only(top:10),
        color:cst,
        child:Center(
          child:TextField(
            maxLength:3,
            cursorWidth:0,
            controller:ctr,
            textAlign:TextAlign.center,
            cursorColor:wht,
            keyboardType:TextInputType.number,
            decoration:InputDecoration(
                border:InputBorder.none,
                counterText:'',
                hintText:hnt,
                hintStyle:TextStyle(color:wht)),
            style:TextStyle(color:wht,fontSize:20,fontWeight:FontWeight.bold),
            onChanged:(t){
              setState((){
                try{
                  if(int.parse(t)>255){
                    txt.text='';
                  }else{
                    r=int.parse(rc.text);
                    g=int.parse(gc.text);
                    b=int.parse(bc.text);
                    String i=en([r,g,b]);
                    txt.text = i;
                    h=int.parse('0xff'+i);
                  }
                }on Exception{
                  txt.text='';
                }
              });
            },
          ),
        ),
      ),
    );
  }
  String en(List<int>b){
    StringBuffer br=new StringBuffer();
    for(int p in b){
      if(p&0xff!=p){throw new FormatException();}
      br.write('${p<16?'0':''}${p.toRadixString(16)}');
    }return br.toString();
  }
  List de(String h){
    String s=h.replaceAll(" ","");
    s=s.toLowerCase();
    if(s.length%2!=0){s="0"+s;}
    Uint8List r=new Uint8List(s.length~/2);
    for(int i=0;i<r.length;i++){
      int d=A.indexOf(s[i*2]);
      int d2=A.indexOf(s[i*2+1]);
      if(d==-1||d2==-1){throw new FormatException();}
      r[i]=(d<<4)+d2;
    }return r;
  }
}