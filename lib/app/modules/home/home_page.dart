import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:slidy_modular/app/modules/home/home_controller.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends ModularState<HomePage, HomeController> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        leading: IconButton(
          icon: Icon(Icons.highlight_off),
          onPressed: controller.logoff,
        ),
      ),
      body: Observer(
        builder: (BuildContext context){
          ///Mensagem de erro.
          if(controller.pokemons.error != null){
            return Center(
              child: RaisedButton(
                child: Text('Erro prescione novamente'),
                onPressed: (){
                  controller.fetchPokemons();
                },
              ),
            );
          }
          ///Load caso ainda esteja carregando.
          if(controller.pokemons.value == null){
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          var list = controller.pokemons.value;

          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (BuildContext context, int index){
              return ListTile(
                title: Text(list[index].name),
              );
            },
          );
        },
      ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //Navigator.pushNamed(context, '/other/${homeController.text}');
            Modular.to.pushNamed('/other');
          },
          ),
      );
  }
}