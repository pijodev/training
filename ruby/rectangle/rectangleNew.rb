puts "---------------------------"
puts "         RECTANGLES"
puts "---------------------------"

puts "Il faut donner en entrée 2 fichiers : c1.txt et c2.txt"
puts "L'objectif est de trouver les coordonées de l'angle en haut à gauche de c1.txt dans c2.txt"
puts ""
puts ""
puts "C2 DOIT être + grand que C1"
puts ""
# TODO 
puts "TODO : vérifier que le code se comporte bien quand il n'y a pas de correspondance + refactoriser en méthodes"
puts ""
puts "~~~~"
puts ""


c1_pat = ARGV[0].to_s
c2_pat = ARGV[1].to_s

#########################################
########## LE VRAI TRAITEMENT ###########
#########################################

# https://stackoverflow.com/questions/17132262/removing-line-breaks-in-ruby
# https://stackoverflow.com/questions/19637677/how-to-delete-specific-characters-from-a-string-in-ruby

# Prepare data
def prepare(myFilePath)
    myFile = File.open(myFilePath)
    #myData = myFile.read()
    myData = []
    myFile.each_line do |line|
        tmp = line
        # Indispensable pour supprimer les breaking lines car each_line reproduit les \n qu'il trouve dans le fichier
        # RQ : normalement tr('myCharToReplace','replacement') utilise des simples guillemets. Attention, il faut assigner le résultat dans une variable !!
        # RQ 2 : .tr!('myCharToReplace','replacement') est destructif et fait le remplacement sur le string sur lequel il est appliqué
        # Mais pour \n il faut les double car sinon il lit '\' ou 'n' et pas "\n" (breakline)
        tmp.tr!("\n",'')
        myData.push(tmp)
    end
    myFile.close()
    return myData
end

c1 = prepare(c1_pat)
c2 = prepare(c2_pat)

cpt_L_c2 = 0
cpt_L_c1 = 0
cpt_E_c2 = 0
cpt_E_c1 = 0

strike = 0
coord = []
inserted = false
strikeMax = c1.length()*c1[0].length()

puts c1
puts ("----")
puts c2
puts ("-------------")
while cpt_L_c2 < c2.length() && strike < strikeMax
    while cpt_E_c2 < c2[0].length() && strike < strikeMax
        puts ("Current position is : #{cpt_L_c2}, #{cpt_E_c2}")

                if (c1[cpt_L_c1][cpt_E_c1] == c2[cpt_L_c2][cpt_E_c2])
                    puts("Found !")
                    strike += 1
                    cpt_E_c1 += 1
                    # Une fois qu'on a la coordonnée initiale, on ne l'écrase plus
                    if inserted == false
                        coord.push(cpt_L_c2)
                        coord.push(cpt_E_c2)
                        puts("Inserted ! #{coord}")
                        inserted = true
                    end
                else
                    # On reset les compteurs de C1 si on perd la correspondance
                    strike = 0
                    cpt_E_c1 = 0
                    cpt_L_c1 = 0
                    coord.pop()
                    coord.pop()
                    puts("Vacuumed ! #{coord}")
                    inserted = false
                end

                
        cpt_E_c2 += 1

        puts cpt_E_c1
        # Strike est la condition de sortie : une fois qu'on a vérifié toutes les valeurs de c1
        if cpt_E_c1 == c1[0].length() && strike != strikeMax
            puts ("Changing c1 line + carret ...")
            cpt_L_c1 += 1
            cpt_E_c1 = 0
            # On reprend les recherches dans C2 directement dans la colonne ou a été localisée la toute premiere occurrence
            cpt_E_c2 = coord[1]
            break
        elsif strike == strikeMax
            puts("Finished !! Located at #{coord}")
            break
        end

    end


    # A vérifier mais normalement ça sert à reprendre les recherches à la colonne 0 si jamais on n'avait pas trouvé de coordonnées.
    # mais c'est potentiellement inutile selon les conditions précédentes.
    if coord.empty?
        cpt_E_c2 = 0
    end
    
    cpt_L_c2 +=1
    puts("")
end

if coord.empty?
    puts("Pas de correspondance trouvée ...")
else
    puts coord
end