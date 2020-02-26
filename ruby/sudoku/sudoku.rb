puts "---------------------------"
puts "         SUDOKU"
puts "---------------------------"

puts "Il faut donner en entrée un fichier .txt contenant une grille sudoku"
puts ""
puts "~~~~"
puts ""


sudokuEntrant = ARGV[0]


######################################
#######                        #######
#######          PREPARE       #######
#######                        #######
######################################

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

puts (" >>> La grille de Sudoku a été transformée sous cette forme <<< ")
transformToMultiDimArray(sudoku)
sudokuArr = transformToMultiDimArray(sudoku)
# Suppression de tableaux vides résiduels causés par transformToMultiDimArray
sudokuArr.delete([])
p sudokuArr

puts ("")
puts (" >>> Place à la résolution <<< ")
puts ("")



######################################
#######                        #######
#######     CALCULATE SQUARE   #######
#######                        #######
######################################


# Crée la coordonnée en fonction de la ligne où se trouve le "_"
def getSquareCoords(myPosition, coordSquare)
    case myPosition
    when 0..2
        coordSquare.push(1)
    when 3..5
        coordSquare.push(2)
    when 6..8
        coordSquare.push(3)
    end
end
# Calculateur des coordonnées du gros carré qui contient le tiret parcouru en ce moment
def checkSquare(linePos, colPos, strPos)
    puts ("Coordonnées du '_' : ligne #{linePos}, colonne #{colPos}, pos : #{strPos}")
    coordSquare = []
    # Créer les coordonnées du gros carré
    getSquareCoords(linePos, coordSquare)
    # getSquareCoords(colPos, coordSquare)
    coordSquare.push(colPos)
    # p coordSquare
    return coordSquare

end

# Défini la range pour chaque carré - onse base sur des coordonnées pour chaque carré.
# La coordonnée 1 est la ligne (de 0 à 8) et la coordonnée est la colonne de 3 (donc varie entre seulement 0, 1 ou 2) 
# ex : carré central = [2, 1] : donc les lignes à récupérer sont les lignes 3 4 et 5 dans la grille, la colonne à récup est la numéro 1
def defineRange(coord)
    s_L_loop = 0
    e_L_loop = 0

    case coord
    when [1,0], [1,1], [1,2]
        s_L_loop = 0
        e_L_loop = 2

    when [2,0], [2,1], [2,2]
        s_L_loop = 3
        e_L_loop = 5

    when [3,0], [3,1], [3,2]
        s_L_loop = 6
        e_L_loop = 8

    end
    
    line_start_stop = []
    line_start_stop.push(s_L_loop)
    line_start_stop.push(e_L_loop)
    return line_start_stop
end

# Regroupe en carrés de 9 chiffres
def calculateInsideSquare(linePos, colPos, strPos, sudokuArr)
    coordSquare = checkSquare(linePos, colPos, strPos)
    p coordSquare 
    line_start_stop = []
    line_start_stop = defineRange(coordSquare)

    # A REFACTORER
    tmp = ""
    # Regrouper tous les éléments appartenant au gros carré en 1 ligne : si un seul "_" appartient au carré, alors on résoud la valeur manquante 
    for i in line_start_stop[0]..line_start_stop[1]
        puts sudokuArr[i][coordSquare[1]]
        tmp.concat(sudokuArr[i][coordSquare[1]])
    end
    # Si il n'y a qu'un seul tiret à remplacer dans le carré, alors on y va
    if tmp.scan(/_/).length() == 1
        for k in 1..9
            if !tmp.include?(k.to_s)
                puts("I found the missing ! #{k}")
                # TODO : trouver le moyen de remplacer le tiret aux coordonnées indiquées par la valeur calculée
                sudokuArr[linePos][colPos].tr!("_", k.to_s)
                puts sudokuArr[linePos][colPos]
            end
        end
    end
    # TODO : vérifier que cette condition permet bien de sortir de la boucle du main. Ca servirait à éviter les potentielles collisions
    # ou alors renvoyer un boolean et n'activer les fonctions calculate uniquement que si le boolean est à false
    # break
end



######################################
#######                        #######
#######     CALCULATE LINE     #######
#######                        #######
######################################


def calculateInsideLine(linePos, colPos, strPos, sudokuArr)

    # A REFACTORER
    tmp = ""
    for i in 0..sudokuArr[linePos].length()-1
        puts sudokuArr[linePos][i]
        tmp.concat(sudokuArr[linePos][i])
    end
    p tmp
    if tmp.scan(/_/).length() == 1
        for k in 1..9
            if !tmp.include?(k.to_s)
                puts("I found the missing ! #{k}")
                # TODO : trouver le moyen de remplacer le tiret aux coordonnées indiquées par la valeur calculée
                sudokuArr[linePos][colPos].tr!("_", k.to_s)
                puts sudokuArr[linePos][colPos]
            end
        end
    end
end


######################################
#######                        #######
#######     CALCULATE COLUMN   #######
#######                        #######
######################################


def calculateInsideCol(linePos, colPos, strPos, sudokuArr)

    # A REFACTORER
    tmp = ""
    for i in 0..sudokuArr.length()-1
        puts sudokuArr[i][colPos][strPos]
        tmp.concat(sudokuArr[i][colPos][strPos])
    end
    p tmp
    if tmp.scan(/_/).length() == 1
        for k in 1..9
            if !tmp.include?(k.to_s)
                puts("I found the missing ! #{k}")
                # TODO : trouver le moyen de remplacer le tiret aux coordonnées indiquées par la valeur calculée
                sudokuArr[linePos][colPos].tr!("_", k.to_s)
                puts sudokuArr[linePos][colPos]
            end
        end
    end
end






######################################
#######                        #######
#######          MAIN          #######
#######                        #######
######################################

def main(sudokuArr)
    for i in 0..sudokuArr.length()-1
        for k in 0..sudokuArr[0].length()-1
            # p sudokuArr[i][k]
            if sudokuArr[i][k].include?("_")
                # FONCTIONNEL en solo 
                # calculateInsideLine(i, k, sudokuArr[i][k].index('_'), sudokuArr)

                # FONCTIONNEL en solo 
                calculateInsideCol(i, k, sudokuArr[i][k].index('_'), sudokuArr)
                
                # FONCTIONNEL en solo 
                # calculateInsideSquare(i, k, sudokuArr[i][k].index('_'), sudokuArr)
            end
        end
    end
    puts ("------")
    p sudokuArr
end


main(sudokuArr)