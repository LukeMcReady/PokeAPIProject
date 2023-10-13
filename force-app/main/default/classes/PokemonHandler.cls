public with sharing class PokemonHandler {
    
    @AuraEnabled
    public static void createPokemonRecord(string pokemonname){
        try {

            Map<String,Object> pokemon = PokeCallouts.getPokemon(pokemonname);
    
    
            Pokemon__c addition = new Pokemon__c();
            addition.Name = pokemonname.capitalize();
            addition.Pokedex_Entry__c =  gatherID(pokemon);
            addition.Moves__c = gatherMoveSet(pokemon);
            addition.Abilities__c = gatherAbilities(pokemon);
            addition.SpriteURL__c = gatherSprite(pokemon);
    
            upsert addition;
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
    


//Methods for gathering all the necessary data from the API, and prepping it for insertion or display.

    public static Integer gatherID(Map<String,Object> pokemon){
        return (integer) pokemon.get('id');
    }

    public static String gatherSprite(Map<String,Object> pokemon){
        Map<String,object> spritesheet = (Map<String,Object>) pokemon.get('sprites');
        return (String) spritesheet.get('front_default');
    }
    
    public static String gatherMoveSet(Map<String,Object> pokemon){
        integer movekey = 0;
        List<String> availablemovelist = new List<String>();
        List<Object> movelist = (List<Object>) pokemon.get('moves');

        While(movekey< movelist.size()){
            Map<String,Object> filteredmovelist = (Map<String,Object>) movelist[movekey];
	        filteredmovelist = (Map<String,Object>) filteredmovelist.get('move');
            availablemovelist.add((String) filteredmovelist.get('name'));
            movekey= movekey +1;
        }   

        return joinStringList(availablemovelist);
    }

    public static String gatherAbilities(Map<String,Object> pokemon){
        integer abilitykey = 0;
        List<String> availableabilities = new List<String>();
        List<Object> abilitylist = (List<Object>) pokemon.get('abilities');

        While(abilitykey< abilitylist.size()){
            Map<String,Object> filteredabilitylist = (Map<String,Object>) abilitylist[abilitykey];
	        filteredabilitylist = (Map<String,Object>) filteredabilitylist.get('ability');
            availableabilities.add((String) filteredabilitylist.get('name'));
            abilitykey= abilitykey +1;
        }   

        return joinStringList(availableabilities);
    }

//Cleans List data into a string datattype to be inserted.
    private static String joinStringList(List<String> input){

        integer a =0;
        while(a < input.size()){
            if(a > 0){
                input[a] = ' '+ input[a];
            }
            a=a+1;  
        }
        return string.join(input, ',');
      
    }
    
}