puts "---------------------------"
puts "         SUDOKU"
puts "---------------------------"

puts "Il faut donner en entrée un fichier .txt contenant une grille sudoku"
puts ""
puts "~~~~"
puts ""


sudokuEntrant = ARGV[0]

# Prepare data
def prepare(myFilePath)
    myFile = File.open(myFilePath)
    myData = []
    myFile.each_line do |line|
        tmp = line
        tmp.tr!("\n",'')
        myData.push(tmp)
    end
    myFile.close()
    return myData
end

sudoku = prepare(sudokuEntrant)
puts sudoku 

# Pour le moment, retourne la grille retranscrite en un tableau de 9 éléments, ou 1 élément est un string de 3 chiffres.
# Cela permettra de repérer facilement la position de chaque "_" dans la grille.
# Cette méthode va créer un tableau à 2 dimensions, où une ligne vaut : [[[], [], []],[[], [], []],[[], [], []]]
def transformToMultiDimArray(sudoku)
    cpt_C = 0
    cpt_L = 0

    nb_col = sudoku[0].length()
    nb_lin = sudoku.length()

    sudokuArr = []

    # Liste des caractères interdits : ils n'entravent pas la retranscription du sudoku.
    caracSpec = ['|', '-', '+']
    strike = 0

    # Parcourir le tableau brut contenant le sudoku tel quel
    while cpt_L < nb_lin
        tmpLine = []
        tmpThird = ""
        tmpThird = ""
        while cpt_C < nb_col
            # Ignorer les séparateurs et ajouter uniquement les chiffres par groupes de 3 ( à l'image de la grille originale dans le txt)
            if !(caracSpec.include?(sudoku[cpt_L][cpt_C].to_s))
                tmpThird.concat(sudoku[cpt_L][cpt_C].to_s)
                strike += 1
            end
            # On pousse les chiffres par groupes de 3 dans le tableau multi-dim
            if strike == 3
                strike = 0
                tmpLine.push(tmpThird)
                tmpThird = ""
            end

            cpt_C += 1
        end
        # 1 ligne contient donc 3 groupes de 3 chiffres soit le total des 9 chiffres / ligne
        sudokuArr.push(tmpLine)
        cpt_C = 0
        cpt_L += 1
    end
    return sudokuArr 
end

transformToMultiDimArray(sudoku)
sudokuArr = transformToMultiDimArray(sudoku)
p sudokuArr

puts (" >>> Place à la résolution traitement <<< ")