obra('El Aleph', ['Borges']).
obra('Cien años de soledad', ['Gabriel García Márquez']).
obra('Antología poética', ['Borges', 'Bioy Casares']).

escribio(Titulo, Autor) :- 
    obra(Titulo, Autores) ,
    member(Autor, Autores).

programaEn(maria, cobol).
programaEn(maria, java).
programaEn(mario, cobol).
programaEn(mario, python).
programaEn(jose, cobol).
programaEn(jorge,java).
programaEn(jorge,python).

sonColegasDeLenguaje(Persona1, Persona2, Lenguaje) :-
    programaEn(Persona1, Lenguaje),
    programaEn(Persona2, Lenguaje),
    Persona1 \= Persona2.

esHijoDe(carlosIII, isabelII).
esHijoDe(ana, isabelII).
esHijoDe(isabelII, pedro).
esHijoDe(isabelII, isa).
esHijoDe(andrew, isabelII).
esHijoDe(edward, isabelII).
esHijoDe(henry, carlosII).
esHijoDe(nelly, mari).
esHijoDe(nelly, gabi).
esHijoDe(mari, flor).
esHijoDe(gabi, octy).

nietoDe(Abuelo, Nieto) :-
    esHijoDe(Abuelo, Padre) ,
    esHijoDe(Padre, Nieto).

sonPrimos(Primo1, Primo2) :-
    esHijoDe(Padre1, Primo1),
    esHijoDe(Padre2, Primo2),
    esHijoDe(Abuelo, Padre1),
    esHijoDe(Abuelo, Padre2),
    Padre1 \= Padre2,
    Primo1 \= Primo2.

animal(cebra).
animal(lombriz).
animal(leon).
animal(perro).
animal(canguro).

habitat(cebra, selva).
habitat(lombriz, bosque).
habitat(canguro, selva).
habitat(leon, selva).
habitat(perro, bosque).
habitat(perro, selva).
come(leon, canguro).
come(leon, perro).
come(leon, cebra).
come(canguro, cebra).

%Si todos los animales que habitan el bioma comen el animal
hostil(Bioma, Animal) :-
    forall(
        (habitat(Depredador, Bioma), Depredador \= Animal),
        come(Depredador, Animal)
   	).

%Si todos los animales que se lo comen habitan en ese bioma.
terrible(Bioma, Animal) :-
    forall(
        come(Depredador, Animal),
        habitat(Depredador, Bioma)
      ).

%Si ninguno de los dos animales se come al otro.
compatible(Animal1, Animal2) :-
    not(come(Animal1, Animal2)),
    not(come(Animal2, Animal1)).

%Si el animal habita en todos los biomas
adaptable(Animal) :-
    forall(
       habitat(_, Bioma),
       habitat(Animal, Bioma)
   	).

%Si el animal solo habita en un bioma
raro(Animal):-
    findall(Bioma, habitat(Animal, Bioma), Biomas),
    length(Biomas, 1).

%Si se come a todos los otros animales del bioma en el que viven
dominante(Animal):-
    habitat(Animal, Bioma), %busco el bioma
    forall(
       %busco los animales que viven en ese bioma y no sean el mismo
      (habitat(OtroAnimal, Bioma), OtroAnimal \= Animal), 
        come(Animal, OtroAnimal)  
    ).
    
    
