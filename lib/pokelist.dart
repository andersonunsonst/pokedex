import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Pokemons {
  final String? name;
  final String? imagemUrl;

  Pokemons({
    this.name,
    this.imagemUrl
  });
}

class Pokelist extends StatefulWidget {
  const Pokelist({super.key});

  @override
  State<Pokelist> createState() => _PokelistState();
}

class _PokelistState extends State<Pokelist> {
  final searchController = TextEditingController();
  List <Pokemons> listaPokemons = [];
  List <Pokemons> todosPokemons = [];
  List results = [];
  List <Pokemons> _filtrados= [];
  late Future _future;

  @override
  void initState() {
    // TODO: implement initState
  //  _filtrados = listaPokemons;
      _future = pegaPokemons();
    super.initState();
  }

  Future<List<Pokemons>> pegaPokemons() async {
    print('pega o pokemonnnnnnnnnnnnnnnnnnnnnnnnnnnnnnn');

    final response = await http.get(Uri.parse('https://pokeapi.co/api/v2/pokemon/?offset=0&limit=151'));
    var json = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      int imgIndex =1;
      for(Map i in json['results']){
          Pokemons pokemons = Pokemons(
            name: i['name'],
            imagemUrl: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/versions/generation-iv/diamond-pearl/$imgIndex.png",
            );
          listaPokemons.add(pokemons);
          imgIndex= imgIndex+1;
      }
      
      todosPokemons = listaPokemons;
        return listaPokemons;

    } else {
        throw('error ao carregar api');
    }
  }


  void searchPokemon(String query){
    List <Pokemons>results = [];

    if(query.isEmpty){
      results = todosPokemons;
      print('limpa');
    }else{
      listaPokemons = todosPokemons;
      results = listaPokemons.where((item)=>item.name!.startsWith(query) ).toList();
      
    }
   // listaPokemons =[];
    setState(() {

      listaPokemons = results;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(title: const Text('Pokedex')),
        body: Center(
          child: Column(
            children: [
              Container(
                child: TextField(
                  controller: searchController,
                  onChanged: searchPokemon,
                  decoration: InputDecoration(
                      
                      prefixIcon: const Icon(Icons.search),
                      hintText: 'Digite o nome de um pokemon',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: const BorderSide(color: Colors.blue))),
                ),
              ),
              Expanded(
            
                child: FutureBuilder(
                    future: _future,
                    
                    builder: (context, snapshot) {

                        return GridView.builder(  
                              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
                              itemCount: listaPokemons.length,
                              itemBuilder: (context, index){
                                 final imgIndex = index+1;
                                 return  Card(
                                  color: Colors.amber,
                                  child: Center(
                                    // child: Text(listaPokemons[index].name.toString()),
                                    child: Column(
                                      children: [
                                        Image.network(listaPokemons[index].imagemUrl.toString()),
                                        Text(listaPokemons[index].name.toString()),
                                      ]),
                                ));
                              },
                           
                        );
                          })
                 
              ),
            ],
          ),
        ));
  }
}
