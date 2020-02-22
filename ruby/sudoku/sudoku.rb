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

# Pour le moment, sert à afficher chaque case du tableau.
# Cette méthode va créer un tableau à 2 dimensions, où une ligne vaut : [[], [], []]
# On pourra ainsi étudier facilement le sudoku
def transformToMultiDimArray(sudoku)
    cpt_C = 0
    cpt_L = 0

    nb_col = sudoku[0].length()
    nb_lin = sudoku.length()

    sudokuArr = []

    while cpt_L < nb_lin
        while cpt_C < nb_col
            if (sudoku[cpt_L][cpt_C].to_s == ('|' || '_' || '-' || '+'))
                puts("Caractère #{sudoku[cpt_L][cpt_C].to_s}")
            else
                puts("Nombre #{sudoku[cpt_L][cpt_C].to_s}")
            end

            cpt_C += 1
        end
        puts("")
        cpt_C = 0
        cpt_L += 1
    end
end

transformToMultiDimArray(sudoku)