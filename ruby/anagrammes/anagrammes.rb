puts "---------------------------"
puts "         ANAGRAMMES"
puts "---------------------------"

puts "Il faut donner en entrée un anagramme d'un des mots présents dans fr.txt, à donner également en paramètre"
puts "ARG 0 = mot à chercher"
puts "ARG 1 = dico"
puts ""
puts "Ne fonctionne pas pour le mot balade. Pourquoi ? Incompréhensible sans débogueur."
puts ""
puts "~~~~"
puts ""

sourceDictionnary = ARGV[1]
word = ARGV[0]

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

dictionnary = prepare(sourceDictionnary)

# Search for word
def searchAna(word, myFilePath)
    arrayOfDico = prepare(myFilePath)
    arrayOfDicoL = arrayOfDico.length()-1
    wordL = word.length()-1
    res = []
    # Strike est la condition d'arrêt
    strike = 0
    # Parcourir chaque mot du dico
    for rank in 0..arrayOfDicoL
        tempDicoWord = arrayOfDico[rank]
        
        # Première vérification : si le mot courant du dico n'a pas la même longueur que le mot courant, on passe
        if wordL == tempDicoWord.length()-1
            strikeMax = wordL
            
            # Regarder chaque lettre du mot entrant
            for letter in 0..wordL
                cpt = 0
                # puts("WORD[#{letter}] : |#{word[letter]}| - DICO[#{letter}] : |#{tempDicoWord[letter]}|")
                # Chaque fois que la lettre du mot entrant correspond à une lettre du mot courant du dico, on strike
                while cpt < wordL
                    if word[letter] == tempDicoWord[cpt]
                        strike +=1
                    end
                    cpt += 1
                end
                # puts("Strike #{strike}/#{strikeMax}")
                if strike == strikeMax
                    res.push(tempDicoWord)
                end
            end
        end
        strike = 0
    end
    if res.empty?
        puts("La recherche n'a pas trouvé d'anagrammes pour : '#{word}' dans le dictionnaire #{arrayOfDico}")
    else
        puts("Résultat de la recherche d'anagrammes pour '#{word}' : #{res}")
    end
end

searchAna(word, sourceDictionnary)