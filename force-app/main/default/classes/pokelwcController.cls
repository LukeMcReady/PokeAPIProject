public  class pokelwcController {
    @AuraEnabled(cacheable=true)
    public static List<Object> queryPokemon(String pokemonname){
        try {
            Map<String,Object> pokemon = PokeCallouts.getPokemon(pokemonname);

        //0:Name,1:ID,2:Moves,3:Abilities,4:Sprite
        List<Object> data = new List<Object>();


        data.add(pokemonname.capitalize());
        data.add(PokemonHandler.gatherID(pokemon));
        data.add(PokemonHandler.gatherMoveSet(pokemon));
        data.add(PokemonHandler.gatherAbilities(pokemon));
        data.add(PokemonHandler.gatherSprite(pokemon));

        return data;
            
        } catch (Exception e) {
            throw new AuraHandledException(e.getMessage());
        }
    }
}