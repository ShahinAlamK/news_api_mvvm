import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_api/controller/news_controller.dart';
import 'package:news_api/view_model/news_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_)=>ViewModel()),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const MyHomePage(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
   //Provider.of<ViewModel>(context,listen: false).getNewsData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: const Text("News Application"),
      ),

      body: Consumer<ViewModel>(builder:(_,data,child){
        if(data.Error!=null){
          return Center(child: Text(data.Error.toString()),);
        }if(data.isLoading){
          return const Center(child: CircularProgressIndicator(),);
        }return ListView.builder(
            itemCount: data.newsList.length,
            itemBuilder: (_,index){
          return ListTile(
            title: Text(data.newsList[index].title!,style:GoogleFonts.roboto(color: Colors.black),),
          );
        });
      }),
    );
  }
}
