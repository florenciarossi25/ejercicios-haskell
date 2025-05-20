horaDeCierre :: String -> Bool -> Int
horaDeCierre dia esFeriado
  | dia == "domingo" && esFeriado = 13
  | dia == "sabado" && not esFeriado = 21
  | esFeriado = 20
  | otherwise = 12 + length dia

main :: IO ()
main = do
  -- probamos la función con algunos ejemplos
  print (horaDeCierre "domingo" True)    -- debería dar 13
  print (horaDeCierre "sabado" False)    -- debería dar 21
  print (horaDeCierre "miercoles" True)  -- debería dar 20
  print (horaDeCierre "jueves" False)    -- debería dar 18 (12 + 6 letras)
