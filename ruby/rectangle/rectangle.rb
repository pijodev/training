puts "---------------------------"
puts "         RECTANGLES"
puts "---------------------------"

puts "Il faut donner en entrée 2 fichiers : c1.txt et c2.txt"
puts "L'objectif est de trouver les coordonées de l'angle en haut à gauche de c1.txt dans c2.txt"
puts ""
puts "La méthode fonctionnelle est detectCoordinates3() - les autres méthodes sont conservées à titre de souvenir des expérimentations foireuses"
puts ""
puts ""
puts "C2 DOIT être + grand que C1"
puts ""
puts "~~~~"
puts ""

path_c1 = ARGV[0].to_s
path_c2 = ARGV[1].to_s

# PRESENTATION 

def readAndClose(myFilePath)

    puts(myFilePath)
    myFIle = File.open(myFilePath)
    puts(myFIle.read())
    myFIle.close()
    
end

def presentation()
    readAndClose(path_c1)
    puts(" ")
    readAndClose(path_c2)
end


#########################################
########## LE VRAI TRAITEMENT ###########
#########################################

# Reconstruction des carrés dans une variable stringifiée
def reconstructC1(myFilePath, mode)
    myFile = File.open(myFilePath)
    myFileData = myFile.read()
    
    if mode == "tableau"
        res = []
        # Ruby gère mal les tableaux multidimensionnels et c'est une vraie galère
        # A la place, on a une méthode qui gère directement ligne par ligne la lecture 
        # d'un fichier et ensuite on peut s'en servir pour simulter un tableau multi dim
        myFileData.each_line do |line|
            res.push(line)
        end
        myFile.close()
    elsif mode == "sring"
        res = ""
        myFileData.each_line do |line|
            res += line
        end
        myFile.close()
    end
    


    return res
end

# c1_stringified = reconstructC1(path_c1)
# c2_stringified = reconstructC1(path_c2)

# Identification de c1 dans c2

def detectCoordinates(c1_stringified, c2_stringified)
    # Parcourir chaque ligne de c1
    for i in 0..c1_stringified.length()-1
        # Parcourir chaque élément dans chaque ligne de c1
        for element in 0..c1_stringified[i].length()
            # Comparer cet élément à chaque élément dans chaque ligne de c2
            cpt_line_c2 = 0    
            cpt_element_c2 = 0
            while (cpt_line_c2 < c2_stringified.length() && cpt_element_c2 < c2_stringified[cpt_line_c2].length())
                if (c1_stringified[i][element] == c2_stringified[cpt_line_c2][cpt_element_c2])

                end
            end
            
        end
        
    end
end

def detectCoordinates2(c1_stringified, c2_stringified)

    coord=[]
    cpt_line_c2 = 0    
    cpt_element_c2 = 0
    strike = false
    while (cpt_line_c2 < c2_stringified.length() && cpt_element_c2 < c2_stringified[cpt_line_c2].length())
        
        for line_c1 in 0..c1_stringified.length()-1
            for element_c1 in 0..c1_stringified[line_c1].length()
                puts("Detection dans C2 à la coordonnée : #{cpt_line_c2}, #{cpt_element_c2}")
                for element_c2 in 0..c2_stringified.length()
                    if (c1_stringified[line_c1][element_c1] == c2_stringified[cpt_line_c2][element_c2])
                        coord.push(cpt_line_c2)
                        coord.push(element_c2)
                        puts(coord)
                        strike = true
                        cpt_element_c2 += 1
                    else
                        strike = false
                        cpt_element_c2 += 1
                    end
                end
            end
            cpt_line_c2 += 1
        end
        cpt_element_c2 = 0
    end

end


def detectCoordinates3(path_c1, path_c2)

    c1_stringified = reconstructC1(path_c1)
    c2_stringified = reconstructC1(path_c2)

    # Pour boucler + facilement

    tot_c1_elem = c1_stringified[0].length()-1
    tot_c1_line = c1_stringified.length()
    taille = (tot_c1_elem) * (tot_c1_line)
    puts("C1 contient #{tot_c1_line} lignes et la première ligne est : |#{c1_stringified[0]}| donc sa longueur est : #{c1_stringified[0].length()}")

    for e in 0..tot_c1_elem-1
        puts("Element courant : #{c1_stringified[0][e]}")
    end
    puts "---"
    puts "---"
    tot_c2_L = c2_stringified.length()-1
    tot_elem_c2 = c2_stringified[0].length()-1

    # Lorsque je trouve la correspondance de C1[0],[0] quelque part dans carré 2, j'incrémente C1[0],[0] vers C1[0],[1] etc  
    cpt_c1_line = 0
    cpt_c1_elem = 0


    savedCoord = []
    2.times{savedCoord.push(0)}

    # Permet de s'assurer de l'intégrité du traitement - on aurait pu trouver plusieurs correspondances à la suite sans que ça soit vrai.
    isSaved = false
    strike = 0
    

    # Parcourir 1 à 1 les éléments de C2
    for line_c2 in 0..tot_c2_L-1
        broken = false
        puts("----------- C2 LINE:#{line_c2} ------------")
        for element_c2 in 0..tot_elem_c2-1

            # Pour chaque élément de C2 on vient le comparer au 1er de C1, et si c'est bon on augmente le strike jusqu'à avoir fait tout C1
            
            # puts("Preparing coordinates : #{line_c2},#{element_c2}")
            puts("  Comparaison de C2[#{line_c2},#{element_c2}] = #{c2_stringified[line_c2][element_c2]} avec C1[#{cpt_c1_line},#{cpt_c1_elem}] = #{c1_stringified[cpt_c1_line][cpt_c1_elem]}")
            
            # Si correspondance entre l'élément actuel de C2 avec le courant de C1
            cpt_c1_line=savedCoord[0]
            cpt_c1_elem=savedCoord[1]
            if ((c2_stringified[line_c2][element_c2] == c1_stringified[cpt_c1_line][cpt_c1_elem]) && !broken)
                puts(">>> Coordonnées = #{line_c2}, #{element_c2} <<<")
                # puts(isSaved)

                # Sauvegarder la première coordonnée trouvée
                if (!isSaved)
                    2.times{savedCoord.pop()}
                    savedCoord.push(line_c2)
                    savedCoord.push(element_c2)
                    puts(">>>>>> Sauvegarde temporaire des coord : #{savedCoord}")
                    isSaved = true
                end
                # Strike sert à savoir combien d'occurences à la suite on a trouvé pour savoir quand on peut s'arrêter
                strike += 1
                puts(">>> Strike : #{strike} / #{taille}")

                # Tant qu'on a pas terminé de vérifier que la ligne en cours de C1 se retrouve aussi dans C2, on peut augmenter l'élément en cours de la ligne en cours
                if cpt_c1_elem < tot_c1_elem
                    cpt_c1_elem += 1
                # Si on a déjà terminé de vérifier la ligne en cours de C1 dans C2, on passe à la ligne suivante grâce à broken
                else
                    # cpt_c1_elem = 0
                    broken = true
                    # break
                end
            else
                if cpt_c1_elem >= tot_c1_elem
                    break
                end

                # Si la correspondance a échoué entre l'élément courant de C2 et C1, on efface les coordonnées sauvées jusqu'à présent
                if (isSaved && cpt_c1_elem >= tot_c1_elem)
                    puts("Effacement de sauvegarde des coord pour les coordonnées : C2#{savedCoord}")
                    2.times{savedCoord.pop()}
                    2.times{savedCoord.push(0)}
                    isSaved = false
                    strike = 0
                end
            end
        end

        # if isSaved
        #     cpt_c1_elem = savedCoord[1]
        # else
        #     cpt_c1_elem = 0
        # end

        # puts(tot_c1_elem)
        # puts(tot_c1_line)
        # puts(taille)
        if (strike == taille)
            puts("Strike = #{strike} / #{taile}")
            break
        end 
        if (cpt_c1_elem == tot_c1_elem)
            cpt_c1_line += 1
            cpt_c1_elem = savedCoord[1]
        end
        # puts("")
        # puts("-----------Changing C2 line------------")
        # puts("")
    end
    if (savedCoord.empty?)
        2.times{savedCoord.push("X")}
    end
    return savedCoord
end




def detectCoordLinear(path_c1, path_c2)

    c1 = reconstructC1(path_c1, "string")
    c2 = reconstructC1(path_c2, "string")

    c1_len = c1.length()
    c2_len = c2.length()

    coord = []

    for i in 0..c1_len
        puts(c1[i])
    end


    return coord
end


# foundCoords = detectCoordinates3(path_c1, path_c2)
foundCoords = detectCoordLinear(path_c1, path_c2)
# puts("Les coordonnées trouvées sont C2[#{foundCoords[0]},#{foundCoords[1]}]")
