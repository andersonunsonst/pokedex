// class PokeAPI{

//   List<Pokemon> pokemon;

//   PokeAPI({this.pokemon});

//   PokeAPI.fromJson(Map<String, dynamic> json){
//     if(json['pokemon'] != null){
//       pokemon = new List<Pokemon>();
//       json['pokemon'].forEach((v){
//         pokemon.add(new Pokemon.fromJson(v));
//       });
//     }
//   }

// }

// class Pokemon{
//   String name;

//   Pokemon({ 
//     this.name
//   });

//   Pokemon.fromJson(){}
// }