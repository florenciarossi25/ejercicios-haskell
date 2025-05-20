type Titulo = String
type Autor = String
data Obra = Obra {titulo:: Titulo, autores:: [Autor]}
instance Show Obra where
  show (Obra t as) = "Título: " ++ t ++ ", Autores: " ++ show as

todasLasObras::[Obra]
todasLasObras = [
  Obra "sandman" ["gaiman"],
  Obra "socorro" ["ElsaBornemann"], 
  Obra "buenos presagios" ["gaiman", "pratchett"]
  ]
-- ¿Es cierto que alguien escribió una determinada obra?
escribio:: Autor -> Titulo -> [Obra] -> Bool
escribio autor titulo todasObras = 
  any(tieneAyT autor titulo) todasObras
  
tieneAyT:: Autor -> Titulo -> Obra -> Bool
tieneAyT unAutor unTitulo obra = 
  titulo obra == unTitulo && elem unAutor(autores obra)

-- ¿Quién o quienes escribieron una obra?
autoresDe:: Titulo -> [Obra] -> [Autor]
autoresDe unTitulo obras = concatMap autores (obrasConTitulo unTitulo obras)

obrasConTitulo:: Titulo -> [Obra] -> [Obra]
obrasConTitulo unTitulo obras = filter((== unTitulo) . titulo) obras --se usa (==) porque titulo es string

-- ¿Qué obra escribió cierta persona?
obrasDe:: Autor -> [Obra] -> [Titulo]
obrasDe unAutor obras = 
  map titulo (filter(elem unAutor . autores ) obras) --se usa elem porque autores es una lista

-- Si es cierto que cierta persona escribió alguna obra, sin importar cual
tieneObras:: Autor -> [Obra] -> Bool
tieneObras unAutor obras = any(\obra -> elem unAutor(autores obra)) obras
--otra forma de hacerlo
--tieneObras unAutor obras =  elem unAutor (concatMap autores obras)

--Si es cierto que cierta obra existe
existeObraConTitulo:: Titulo -> [Obra] -> Bool
existeObraConTitulo unTitulo obras = any((==unTitulo) . titulo) obras

main :: IO ()
main = do
  print("Es cierto que alguien escribio una determinada obra")
  print (escribio "ElsaBornemann" "socorro" todasLasObras)
  print()
  print("Quien o quienes escribieron una obra")
  print(autoresDe "socorro" todasLasObras)
  print()
  print("Que obra escribio cierta persona")
  let resultado = obrasDe "gaiman" todasLasObras
  print resultado
  print()
  print("Si es cierto que cierta persona escribió alguna obra, sin importar cual")
  print(tieneObras "ElsaBornemann" todasLasObras)
  print()
  print("Si es cierto que cierta obra existe")
  print(existeObraConTitulo "socorro" todasLasObras)
  
  