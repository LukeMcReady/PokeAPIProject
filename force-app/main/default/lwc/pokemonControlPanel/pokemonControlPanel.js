import { LightningElement, wire, track } from 'lwc';
import createPokemonRecord from "@salesforce/apex/PokemonHandler.createPokemonRecord"
import queryPokemon from "@salesforce/apex/pokelwcController.queryPokemon"

export default class PokemonControlPanel extends LightningElement {

    pokemonname;
    displayname=null;
    id=null;
    moves=null;
    abilities=null;
    sprite=null;
    callsign=null;

    checkone=false;


    handleSearch(event){
        this.pokemonname= event.target.value;
        console.log(this.pokemonname)

    }

    handleClick(event) {
        queryPokemon({ pokemonname: this.pokemonname })
      .then((result) => {
        this.displayname = result[0];
        this.id = result[1];

        if(this.id == 150 || this.id == 151 || this.id == 144
            || this.id == 145 || this.id == 146 || this.id == 243
            || this.id == 244 || this.id == 245 || this.id == 249
            || this.id == 250 || this.id == 251 || this.id == 377
            || this.id == 378 || this.id == 379 || this.id == 380
            || this.id == 381 || this.id == 382 || this.id == 383
            || this.id == 384 || this.id == 385 || this.id == 386
            || this.id == 386 || this.id == 480 || this.id == 481
            || this.id == 482 || this.id == 483 || this.id == 484
            || this.id == 485 || this.id == 486 || this.id == 487
            || this.id == 488 || this.id == 489 || this.id == 490
            || this.id == 490 || this.id == 491 || this.id == 492
            || this.id == 494 || this.id == 638 || this.id == 639
            || this.id == 640 || this.id == 641 || this.id == 642
            || this.id == 643 || this.id == 644 || this.id == 645
            || this.id == 646 || this.id == 647 || this.id == 648
            || this.id == 649){
                this.callsign= "The Legendary Pokemon"
            }else if(this.id == 493){
                this.callsign= "The Supreme Pokemon"
            }

        this.moves = result[2];
        this.abilities = result[3];
        this.sprite = result[4];
        this.error = undefined;
      })
      .catch((error) => {
        this.error = error;
        this.contacts = undefined;
      });
    }

    saveAction(event){
        this.checkone=true;
        createPokemonRecord({pokemonname: this.pokemonname});

    }

 

}