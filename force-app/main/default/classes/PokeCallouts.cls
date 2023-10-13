public with sharing class PokeCallouts {
    public static Map<String, Object> getPokemon(String pokename) {

        Map<String,Object> pokemon = new Map<String,Object>();


        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://pokeapi.co/api/v2/pokemon/'+ cleanSearch(pokename)+'/');
        request.setMethod('GET');
        HttpResponse response = http.send(request);

        if(response.getStatusCode()==200){
            pokemon = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());
        }
        return pokemon;

    }

    public static String cleanSearch(String pokename){
        
        pokename=pokename.deleteWhitespace();
        pokename=pokename.toLowerCase();

        return pokename;
    }
}